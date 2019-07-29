pragma solidity ^0.5.0;
import "./runtime.sol";
library pb_Test{
  //enum definition

  //struct definition
  struct Data {
    int32 test;
    int256 test2;
    int256 test3;
    //non serialized field for map

  }
  // Decoder section
  function decode(bytes memory bs) internal pure returns (Data memory) {
    (Data memory x,) = _decode(32, bs, bs.length);
    return x;
  }
  function decode(Data storage self, bytes memory bs) internal {
    (Data memory x,) = _decode(32, bs, bs.length);
    store(x, self);
  }
  // innter decoder
  function _decode(uint p, bytes memory bs, uint sz)
      internal pure returns (Data memory, uint) {
    Data memory r;
    uint[4] memory counters;
    uint fieldId;
    _pb.WireType wireType;
    uint bytesRead;
    uint offset = p;
    while(p < offset+sz) {
      (fieldId, wireType, bytesRead) = _pb._decode_key(p, bs);
      p += bytesRead;
      if (false) {}
      else if(fieldId == 1)
          p += _read_test(p, bs, r, counters);
      else if(fieldId == 2)
          p += _read_test2(p, bs, r, counters);
      else if(fieldId == 3)
          p += _read_test3(p, bs, r, counters);
      else revert();
    }
    p = offset;

    while(p < offset+sz) {
      (fieldId, wireType, bytesRead) = _pb._decode_key(p, bs);
      p += bytesRead;
      if (false) {}
      else if(fieldId == 1)
          p += _read_test(p, bs, nil(), counters);
      else if(fieldId == 2)
          p += _read_test2(p, bs, nil(), counters);
      else if(fieldId == 3)
          p += _read_test3(p, bs, nil(), counters);
      else revert();
    }
    return (r, sz);
  }

  // field readers
  function _read_test(uint p, bytes memory bs, Data memory r, uint[4] memory counters) internal pure returns (uint) {
    (int32 x, uint sz) = _pb._decode_sint32(p, bs);
    if(isNil(r)) {
      counters[1] += 1;
    } else {
      r.test = x;
      if(counters[1] > 0) counters[1] -= 1;
    }
    return sz;
  }
  function _read_test2(uint p, bytes memory bs, Data memory r, uint[4] memory counters) internal pure returns (uint) {
    (int256 x, uint sz) = _pb._decode_sol_int256(p, bs);
    if(isNil(r)) {
      counters[2] += 1;
    } else {
      r.test2 = x;
      if(counters[2] > 0) counters[2] -= 1;
    }
    return sz;
  }
  function _read_test3(uint p, bytes memory bs, Data memory r, uint[4] memory counters) internal pure returns (uint) {
    (int256 x, uint sz) = _pb._decode_sol_int256(p, bs);
    if(isNil(r)) {
      counters[3] += 1;
    } else {
      r.test3 = x;
      if(counters[3] > 0) counters[3] -= 1;
    }
    return sz;
  }

  // struct decoder

  // Encoder section
  function encode(Data memory r) internal pure returns (bytes memory) {
    bytes memory bs = new bytes(_estimate(r));
    uint sz = _encode(r, 32, bs);
    assembly { mstore(bs, sz) }
    return bs;
  }

  // inner encoder
  function _encode(Data memory r, uint p, bytes memory bs)
      internal pure returns (uint) {
    uint offset = p;

    p += _pb._encode_key(1, _pb.WireType.Varint, p, bs);
    p += _pb._encode_sint32(r.test, p, bs);
    p += _pb._encode_key(2, _pb.WireType.LengthDelim, p, bs);
    p += _pb._encode_sol_int256(r.test2, p, bs);
    p += _pb._encode_key(3, _pb.WireType.LengthDelim, p, bs);
    p += _pb._encode_sol_int256(r.test3, p, bs);

    return p - offset;
  }

  // nested encoder
  function _encode_nested(Data memory r, uint p, bytes memory bs)
      internal pure returns (uint) {
    uint offset = p;
    p += _pb._encode_varint(_estimate(r), p, bs);
    p += _encode(r, p, bs);
    return p - offset;
  }

  // estimator
  function _estimate(Data memory r) internal pure returns (uint) {
    uint e;

    e += 1 + _pb._sz_sint32(r.test);
    e += 1 + 35;
    e += 1 + 35;

    return e;
  }


  //store function
  function store(Data memory input, Data storage output) internal{
    output.test = input.test;
    output.test2 = input.test2;
    output.test3 = input.test3;

  }


  //utility functions
  function nil() internal pure returns (Data memory r) {
    assembly { r := 0 }
  }
  function isNil(Data memory x) internal pure returns (bool r) {
    assembly { r := iszero(x) }
  }
} //library pb_Test
