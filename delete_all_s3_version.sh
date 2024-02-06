# List all object versions and extract the object keys and version IDs
versions=$(aws s3api list-object-versions --bucket chrisleejean.com --output json)

# Iterate through each version and delete it
for version in $(echo "${versions}" | jq -r '.Versions[] | @base64'); do
    key=$(echo ${version} | base64 --decode | jq -r '.Key')
    version_id=$(echo ${version} | base64 --decode | jq -r '.VersionId')
    aws s3api delete-object --bucket chrisleejean.com --key "${key}" --version-id "${version_id}"
done

# Delete markers
for delete_marker in $(echo "${versions}" | jq -r '.DeleteMarkers[] | @base64'); do
    key=$(echo ${delete_marker} | base64 --decode | jq -r '.Key')
    version_id=$(echo ${delete_marker} | base64 --decode | jq -r '.VersionId')
    aws s3api delete-object --bucket chrisleejean.com --key "${key}" --version-id "${version_id}"
done

