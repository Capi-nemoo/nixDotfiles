
USERNAME="capi-nemoo"
GITHUB_REPOS=~/repos/github_projects.txt
LOCAL_REPOS_DIR=~/repos

while read repo; do
    if [ ! -d "$LOCAL_REPOS_DIR/$repo" ]; then
        echo "Cloning: $repo"
        git clone "https://github.com/$USERNAME/$repo.git" "$LOCAL_REPOS_DIR/$repo"
    fi
done < "$GITHUB_REPOS"
