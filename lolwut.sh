#!/bin/sh

brew install npm
npm install alex --global
git config --global init.templatedir '~/.git-templates'
mkdir -p ~/.git-templates/hooks
cat > ~/.git-templates/hooks/commit-msg <<- EOM
#!/bin/bash

ALEX=\$(cat "\$1" | alex --color)
if [ \$? -eq 0 ]
then
  exit 0
else
  echo "There was a problem with your commit message: \$(cat "\$1")"
  echo "\$ALEX"
  echo ""
  echo "Please edit your commit with 'git commit --amend' and try again."
  exit 1
fi
EOM
chmod +x ~/.git-templates/hooks/commit-msg
find ~/ -type d -name .git -exec sh -c "cd \"{}\"/../ && git init" \;
