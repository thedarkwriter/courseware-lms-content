class flags::debug {
  exec {
    default:
      path => '/bin/',
      ;
    'do something':
      command => 'sleep 1',
      ;
    'do another thing':
      command => 'sleep 5',
      ;
    'do something else':
      command => 'sleep 0',
      ;
    'do that other thing':
      command => 'sleep 0',
      ;
    'do one more thing':
      command => 'sleep 0',
      ;
  }
}
