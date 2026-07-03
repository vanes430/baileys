#!/bin/bash
# Kompilasi WAProto.proto menjadi berkas JavaScript dan tipe TypeScript menggunakan Bun
bunx pbjs -t static-module -w commonjs -o ./WAProto/index.js ./WAProto/WAProto.proto
bunx pbts -o ./WAProto/index.d.ts ./WAProto/index.js