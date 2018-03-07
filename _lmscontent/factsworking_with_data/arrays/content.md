<body>

<h3 id="toc_0">4c. Facts - Working with data: Overview</h3>

<h2 id="toc_1">Introduction:</h2>

<p>Other facts contain more complex values. They might contain data structures like arrays or hashes. If you want to learn more about arrays and hashes before diving in, check out the syntax section in <a href="https://puppet.com/docs/puppet/5.3/lang_data_array.html">the Puppet docs.</a></p>

<h3 id="toc_2">Arrays:</h3>

<p>Arrays allow you to define and work with a large set of the same type of data. An array is a series of values that looks like [&#39;one&#39;, &#39;two&#39;, &#39;three&#39;], denoted by square brackets. You can retrieve values from an array using the position, or index, that it is in. For example, to retrieve the first value in an array, you will call on the value at <code>index 0:</code></p>

<h3 id="toc_3">Create an array</h3>

<div><pre><code class="language-none">$my_array = [&#39;one&#39;, &#39;two&#39;, &#39;three&#39;]

# Access values inside array

$first  = $my_array[0]              # equal to &#39;one&#39;

$second = $my_array[1]              # equal to &#39;two&#39;

$third  = $my_array[2]              # equal to &#39;three&#39;

**Note:** The first value in the array begins at index 0, not index 1.</code></pre></div>

<p><img src="image_5.png" alt="image alt text"></p>

<h2 id="toc_4">Task:</h2>

<p>Set the variable <code>$job</code> to the 2nd value in the <code>$office_party array</code>.</p>

<h3 id="toc_5">Sample array</h3>

<div><pre><code class="language-none">$office_party = [&#39;worker&#39;, &#39;manager&#39;, &#39;engineer&#39; ]

# Set to the 2nd value in $office_party

$job = &lt;PUT ANSWER HERE&gt;</code></pre></div>

<p>Click the test button when you're done to see your results.</p>

<p><iframe src="https://magicbox.classroom.puppet.com/facts/working_with_arrays" width="100%" height="500px" frameborder="0"></iframe></p>




</body>
