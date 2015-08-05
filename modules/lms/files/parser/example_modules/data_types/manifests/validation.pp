class data_types::validation (
    $example_string = $data_types::params::example_string,
    $example_integer = $data_types::params::example_integer, 
    $example_bool = $data_types::params::example_bool,
    $example_array = $data_types::params::example_array,
    $example_hash = $data_types::params::example_hash,
  ) inherits data_types::params {
    notice($example_string)
    notice($example_integer)
    notice($example_bool)
    notice($example_array)
    notice($example_hash)
}
