rm -rf public
# 更新 main
git add .
git config --global core.autocrlf true
git add .
git commit -m "v0.2.18-lts.2(2023-10-24)"
git push -f
