#!/bin/bash - 

mapfile -t used_actions_and_vesions < <( rg "uses:" .github | awk --field-separator=":" '{ print $NF };' | xargs -I{} echo {} | grep -vE '@[^ ]{8,}'| grep -v "^./" | sort --unique )

for actionversion in "${used_actions_and_vesions[@]}"; do
    echo "Pinning ${actionversion}"
    repo_uri=$(printf "%s\n" "${actionversion}" | cut -d "@" -f 1 | cut -d "/" -f1-2 )
    version=$(cut -d "@" -f 2 <<< "${actionversion}")
    shasum=$(git ls-remote --tags --refs "https://github.com/${repo_uri}.git" | grep "${version}$" | awk '{ print $1 ;}')

    # skip repos where we failed to determined the version
    if [[ -z "${shasum}" ]]; then
        echo "Failed to pin ${actionversion}"
        continue
    fi
    pinned_version=$(printf "%s@%s # %s\n" "${repo_uri}" "${shasum}" "${version}")

    sed -i "s|${actionversion}|${pinned_version}|g" .github/workflows/*
done

mapfile -t used_actions_and_vesions < <( rg "uses:" .github | awk --field-separator=":" '{ print $NF };' | xargs -I{} echo {} | grep -vE '@[^ ]{8,}'| grep -v "^./" | sort --unique )

if (( ${#used_actions_and_vesions[@]} > 0 )); then
    echo "Remaining actions: ${used_actions_and_vesions[*]}"
fi
