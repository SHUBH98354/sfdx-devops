export HOME=/root
git config --global --add safe.directory '*'
git fetch origin "+refs/heads/*:refs/remotes/origin/*"
sf sgd:source:delta --help
sf sgd:source:delta -a 53 --to HEAD --from origin/$BASE_BRANCH --output . -i manifest/mdapi/.sgdignore --generate-delta
ls
echo "--- package.xml generated with added and modified metadata since $LAST_DEPLOYED_COMMIT in Master ---"
cat package/package.xml
echo
echo "--- destructiveChanges.xml generated with deleted metadata since $LAST_DEPLOYED_COMMIT in Master ---"
cat destructiveChanges/destructiveChanges.xml
echo
