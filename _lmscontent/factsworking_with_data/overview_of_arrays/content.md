## Introduction:
Other facts contain more complex values. They might contain data structures like arrays or hashes. If you want to learn more about arrays and hashes before diving in, check out the syntax section in [the Puppet docs](https://puppet.com/docs/puppet/5.3/lang_data_array.html "").

### Arrays:
Arrays allow you to define and work with a large set of the same type of data. An array is a series of values that looks like <code>['one', 'two', 'three']</code>, denoted by square brackets. Puppet is like most programming languages and uses zero-based index counting: the first element of any series of values is assigned the index 0&nbsp;instead of the index 1.&nbsp;You can retrieve values from an array using the position, or index, that it is in. For example, to retrieve the first value in an array variable&nbsp; <code>$array</code>, you would access it using the index 0, or <code>$array[0].&nbsp;</code>

### Create an array
<div>
<pre><code class="language-none">$my_array = ['one', 'two', 'three']

# Access values inside array

$first  = $my_array[0]              # equal to 'one'

$second = $my_array[1]              # equal to 'two'

$third  = $my_array[2]              # equal to 'three'

**Note:** The first value in the array begins at index 0, not index 1.</code></pre>
</div>
## Task:
<iframe src="https://magicbox.whatsaranjit.com/facts/working_with_arrays" width="100%" height="500px" frameborder="0" />