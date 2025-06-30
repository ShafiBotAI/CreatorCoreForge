import { fail } from 'danger';

if (!github.pr.body || github.pr.body.length < 10) {
  fail('PR description is too short');
}

const modifiedFiles = danger.git.modified_files;
if (!modifiedFiles.includes('tests')) {
  fail('PR must modify or add tests');
}
