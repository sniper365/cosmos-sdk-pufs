# -*- coding: utf-8 -*-
# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: solidity-protobuf-extensions.proto
"""Generated protocol buffer code."""
from google.protobuf import descriptor as _descriptor
from google.protobuf import descriptor_pool as _descriptor_pool
from google.protobuf import message as _message
from google.protobuf import reflection as _reflection
from google.protobuf import symbol_database as _symbol_database
# @@protoc_insertion_point(imports)

_sym_db = _symbol_database.Default()


from google.protobuf import descriptor_pb2 as google_dot_protobuf_dot_descriptor__pb2


DESCRIPTOR = _descriptor_pool.Default().AddSerializedFile(b'\n\"solidity-protobuf-extensions.proto\x12\x08solidity\x1a google/protobuf/descriptor.proto\";\n\x0b\x46ileOptions\x12\x14\n\x0cpackage_name\x18\x01 \x01(\t\x12\x16\n\x0e\x64irectory_path\x18\x02 \x01(\t:K\n\x0c\x66ile_options\x12\x1c.google.protobuf.FileOptions\x18\xd0\x86\x03 \x01(\x0b\x32\x15.solidity.FileOptionsBTZRgithub.com/datachainlab/solidity-protobuf/protobuf-solidity/src/protoc/go;solidityb\x06proto3')


FILE_OPTIONS_FIELD_NUMBER = 50000
file_options = DESCRIPTOR.extensions_by_name['file_options']

_FILEOPTIONS = DESCRIPTOR.message_types_by_name['FileOptions']
FileOptions = _reflection.GeneratedProtocolMessageType('FileOptions', (_message.Message,), {
  'DESCRIPTOR' : _FILEOPTIONS,
  '__module__' : 'solidity_protobuf_extensions_pb2'
  # @@protoc_insertion_point(class_scope:solidity.FileOptions)
  })
_sym_db.RegisterMessage(FileOptions)

if _descriptor._USE_C_DESCRIPTORS == False:
  google_dot_protobuf_dot_descriptor__pb2.FileOptions.RegisterExtension(file_options)

  DESCRIPTOR._options = None
  DESCRIPTOR._serialized_options = b'ZRgithub.com/datachainlab/solidity-protobuf/protobuf-solidity/src/protoc/go;solidity'
  _FILEOPTIONS._serialized_start=82
  _FILEOPTIONS._serialized_end=141
# @@protoc_insertion_point(module_scope)
