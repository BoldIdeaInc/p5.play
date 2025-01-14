#! /bin/sh

set -eu

echo "Regenerating documentation."

rm -rf docs &&
npm run docs &&

echo "Copying/moving files in working dir."

npm run copy:p5 &&
rm -rf __temp_examples __temp_docs __temp_p5.game.js
cp -r examples/ __temp_examples/ &&
mv docs __temp_docs
cp lib/p5.game.js __temp_p5.game.js &&

echo "Switching to gh-pages branch."

git checkout gh-pages &&

rm -rf examples docs lib/p5.game.js
mv __temp_examples examples &&
mv __temp_docs docs &&
mv __temp_p5.game.js lib/p5.game.js &&

echo "Staging new/changed files."

git add examples/ docs/ lib/p5.game.js &&

git commit -m 'updated gh-pages' &&
git push origin gh-pages &&

git checkout master
