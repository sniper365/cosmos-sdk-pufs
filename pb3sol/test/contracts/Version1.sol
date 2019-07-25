pragma solidity ^0.4.17;

import "./libs/StorageAccessor.sol";
import "./libs/StrUtil.sol";
import "./libs/pb/TaskList_pb.sol";

contract Version1 is StorageAccessor {
    //instance method style
    using pb_Rewards for pb_Rewards.Data;
    using pb_TaskList_UrgentTask for pb_TaskList_UrgentTask.Data;
    pb_Rewards.Data public tmp;
    
	constructor(address storageAddress) StorageAccessor(storageAddress) public {
    }

    function addReward(string key) public writer returns (uint256) {
        pb_Rewards.Data memory r;
        //id array
        r.id = new uint256[](2);
        r.id[0] = 123;
        r.id[1] = 456;
        
        //fixed64
        r.f1 = 111;

        //array of message which contains array of message
        r.f2 = new pb_TaskList_Task.Data[](2);

        r.f2[0].due_date = 20180303;
        r.f2[0].progresses = new pb_TaskList_Task_Progress.Data[](2);
        r.f2[0].progresses[0].step = 1;
        r.f2[0].progresses[0].prog_type = pb_TaskList.ProgressType_Start();
        r.f2[0].progresses[1].step = -111;
        r.f2[0].progresses[1].prog_type = pb_TaskList.ProgressType_Done();
        require(r.f2[0].progresses[1].prog_type == 34 && r.f2[0].progresses[0].prog_type == 12);

        r.f2[1].due_date = 20180401;
        r.f2[1].progresses = new pb_TaskList_Task_Progress.Data[](1);
        r.f2[1].progresses[0].step = 3;

        //int64 array
        r.f3 = new int64[](2);
        r.f3[0] = 333;
        r.f3[1] = 444;

        //int128 with negative value
        r.f4 = -3;

        saveBytesByString(key, r.encode());
        return r.id[0];
    }

    function loadReward(string key) public writer {
        bytes memory b = loadBytesByString(key);
        tmp.decode(b);

        pb_TaskList_UrgentTask.Data memory ut; 
        ut.explanation = "hoge";
        ut.priority = 1010;

        pb_TaskList_UrgentTask.Data memory ut2;
        ut2.explanation = "fuga";
        ut2.priority = 2020;

        tmp.add_f5("foo", ut);
        tmp.add_f5("bar", ut2);

        tmp.get_f5("foo").add_messages(11, "Foo");
        tmp.get_f5("bar").add_messages(12, "Bar");

        saveBytesByString(key, tmp.encode());//*/
    }//*/

    function getBytes() public view returns (bytes) {
        return tmp.encode();
    }

    function check() public view reader returns (int) {
        if (tmp.id[0] != 123) { return -1; }
        if (tmp.id[1] != 456) { return -2; }
        if (tmp.f1 != 111) { return -3; }
        if (tmp.f2[0].due_date != 20180303) { return -4; }
        if (tmp.f2[1].due_date != 20180401) { return -5; }
        if (tmp.f2[0].progresses[0].step != 1) { return -6; }
        if (tmp.f2[0].progresses[0].prog_type != pb_TaskList.ProgressType_Start()) { return -9; }
        if (tmp.f2[0].progresses[1].step != -111) { return -7; }
        if (tmp.f2[0].progresses[1].prog_type != pb_TaskList.ProgressType_Done()) { return -10; }
        if (tmp.f2[1].progresses[0].step != 3) { return -8; }
        if (tmp.f4 != -3) { return -9; }    

        bool found; 
        pb_TaskList_UrgentTask.Data storage f5;
        string memory m;

        (found, f5) = tmp.search_f5("baz");
        if (found) { return -16; }
        (found, f5) = tmp.search_f5("foo");
        if (!found) { return -15; }
        (found, m) = f5.search_messages(11);
        if (!found || !StrUtil.Compare(m, "Foo")) { return -11; }
        if (!found || !StrUtil.Compare(f5.explanation, "hoge")) { return -12; }
        (found, f5) = tmp.search_f5("bar");
        if (!found) { return -13; }
        (found, m) = f5.search_messages(12);
        if (!found || !StrUtil.Compare(m, "Bar")) { return -14; }
        return 0;
    }
}
