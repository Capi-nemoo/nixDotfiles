GITHUB_REPOS=~/repos/github_projects.txt
LOCAL_REPOS_DIR=~/repos

while read repo; do
    if [ ! -d "$LOCAL_REPOS_DIR/$repo" ]; then
        echo "Missing: $repo"
    fi
done < "$GITHUB_REPOS"

