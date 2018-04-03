<body>

<h2 id="toc_1">Introduction:</h2>

<p>A hash is a series of key-value pairs denoted by curly braces that looks like:</p>
<code>{ </br>
'cat' = 'meow',</br> 
'dog' = 'woof',</br> 
'cow' = 'moo',</br>
 }</br>
</code></br>
<p>Each key-value pair in the hash looks like:</p> 
<code>'key' = 'value'</br></code></br>
<p>We can retrieve values from a hash using the key name:</p>

<div><pre><code class="language-none"># First create a hash
$my_hash = {</br>
'cat' = 'meow',</br> 
'dog' = 'woof',</br> 
'cow' = 'moo',</br>
}</br>

# Access values inside hash

$feline  = $my_hash['cat']             # equal to 'meow'

$canine = $my_hash['dog']             # equal to 'woof'

$bovine  = $my_hash['cow']             # equal to 'moo'</code></pre></div>

<h2 id="toc_2">Task:</h2>
<p><iframe src="https://magicbox.classroom.puppet.com/facts/working_with_hashes" width="100%" height="500px" frameborder="0"></iframe></p>




</body>
