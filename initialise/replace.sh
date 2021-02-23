package_name=""

# Absolute path to this script, e.g. /home/user/bin/foo.sh
script_name=$(readlink -f "$0")
# absolute path this script is in, thus /home/user/bin
script_path=$(dirname "${script_name}")

while IFS="" read -r line || [ -n "$line" ]; do
  conf_variable="${line%%=*}"
  conf_value="${line#*=}"

  if test "${conf_variable}" = "PACKAGE_NAME"; then
    package_name="${conf_value}"
  fi

  echo "Replacing '<<${conf_variable}>>' with '${conf_value}'"
  
  find . -type f -exec sed -i 's/<<'"${conf_variable}"'>>/'"${conf_value}"'/g' {} +
done < ./config.txt

cd ..

if test -n "${package_name}"; then
  mv "${script_path}" ../"${package_name}"
fi

rm -r ./initialise
