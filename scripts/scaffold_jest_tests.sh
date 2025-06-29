#!/usr/bin/env bash
set -e
file=$1
if [ -z "$file" ]; then
  echo "Usage: scaffold_jest_tests.sh <module.ts>" >&2
  exit 1
fi
name=$(basename "$file" .ts)
test_dir=$(dirname "$file")/../test
mkdir -p "$test_dir"
cat > "$test_dir/${name}.test.ts" <<TST
import { ${name} } from '../src/${name}';

describe('${name}', () => {
  it('should work', () => {
    expect(${name}()).toBeDefined();
  });
});
TST
