# How To - HTML - Skeleton

## HTML Structure Example [^1] [^2] [^3]

```
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <title>SKELETON</title>

        <meta name="author" content="AUTHOR">
        <meta name="description" content="DESCRIPTION">
        <meta name="keywords" content="KEYWORD, KEYWORD">
        <meta name="robots" content="index, follow">
        <meta name="mobile-web-app-capable" content="yes">
        <meta name="apple-mobile-web-app-capable" content="yes">

        <!-- Styles -->
        <link rel="stylesheet" href="./css/style.css">
        <link rel="shortcut icon" type="image/x-icon" href="./img/favicon.ico">
    </head>

    <body>
        <header>
            <figure>
                <img src="./img/logo.png" alt="logo"/>
            </figure>
        </header>

        <nav>
            <a href="index.html">Home</a>
            <a href="services.html">Services</a>
            <a href="contact.html">Contact</a>
            <a href="about.html">About Us</a>
        </nav>

        <main>
            <article>
                <h1>Headline Level 1</h1>

                <section>
                    <h2>Headline Level 2</h2>
                    <h3>Headline Level 3</h3>
                    <h4>Headline Level 4</h4>
                    <h5>Headline Level 5</h5>
                    <h6>Headline Level 6</h6>
                </section>

                <section>
                    <ol>
                        <li>First Entry</li>
                        <li>Second Entry</li>
                        <li>Third Entry</li>
                    </ol>
                    <ul>
                        <li>First Entry</li>
                        <li>Second Entry</li>
                        <li>Third Entry</li>
                    </ul>
                </section>

                <section>
                    <blockquote cite="http://developer.mozilla.org">
                        <p>That's a quote</p>
                        <cite>vom Mozilla Developer Center.</cite>
                    </blockquote>

                    <dl>
                        <dd>The state of being happy.</dd>
                        <dt>rejoice</dt>
                    </dl>

                    <details>
                        <summary>Some details</summary>
                        <p>More info about the details.</p>
                    </details>
                </section>

                <section>
                    <table>
                        <thead>
                            <tr>
                                <th>Header</th>
                                <th>Header</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>Content</td>
                                <td>Content</td>
                            </tr>
                        </tbody>
                        <tfoot>
                            <tr>
                                <td>Footer</td>
                                <td>Footer</td>
                            </tr>
                        </tfoot>
                    </table>
                </section>

                <section>
                    <figure>
                        <img src="./img/elephant.png" alt="logo"/>
                        <figcaption>An elephant at sunset</figcaption>
                    </figure>

                    <audio controls src="https://file-examples-com.github.io/uploads/2017/11/file_example_MP3_700KB.mp3">Your browser does not support the element.</audio>

                    <video width="320" height="240" controls>
                    <source src="https://file-examples-com.github.io/uploads/2017/04/file_example_MP4_480_1_5MG.mp4" type="video/mp4">
                    Your browser does not support the video tag.
                    </video>
                </section>
                <section>
                    <label for="fuel">Fuel level:</label>
                    <meter id="fuel" min="0" max="100" low="33" high="66" optimum="80" value="50">at 50/100</meter>
                    <progress value="70" max="100">70 %</progress>
                </section>
                <section>
                    <form oninput="result.value=parseInt(a.value)+parseInt(b.value)">
                        <input type="range" id="b" name="b" value="50" /> +
                        <input type="number" id="a" name="a" value="10" /> =
                        <output name="result" for="a b">60</output>
                    </form>
                </section>
                <section>
                    <form action="" method="">
                        <fieldset>
                            <select>
                                    <optgroup label="Gruppe 1">
                                        <option>Option 1.1</option>
                                    </optgroup>
                                    <optgroup label="Gruppe 2">
                                        <option>Option 2.1</option>
                                        <option>Option 2.2</option>
                                    </optgroup>
                                    <optgroup label="Gruppe 3" disabled>
                                        <option>Option 3.1</option>
                                        <option>Option 3.2</option>
                                        <option>Option 3.3</option>
                                    </optgroup>
                                </select>
                            <input type="radio" id="radio">
                            <label for="radio">Click me</label>
                            <input id="input1" type="text">
                            <label for="input1">Type me</label>
                        </fieldset>
                        <fieldset>
                            <legend>Title</legend>
                            <label for="story">Tell us your story:</label>
                            <textarea id="story" name="story" rows="5" cols="33">It was a dark and stormy night...</textarea>
                        </fieldset>
                        <fieldset>
                            <legend>Title</legend>
                            <button class="favorite styled" type="button">Add to favorites</button>
                        </fieldset>
                        <fieldset>
                            <input type="button"></input>
                            <input type="checkbox"></input>
                            <input type="color"></input>
                            <input type="date"></input>
                            <input type="datetime-local"></input>
                            <input type="email"></input>
                            <input type="file"></input>
                            <input type="hidden"></input>
                            <input type="image"></input>
                            <input type="month"></input>
                            <input type="number"></input>
                            <input type="password"></input>
                            <input type="radio"></input>
                            <input type="range"></input>
                            <input type="reset"></input>
                            <input type="search"></input>
                            <input type="submit"></input>
                            <input type="tel"></input>
                            <input type="text"></input>
                            <input type="time"></input>
                            <input type="url"></input>
                            <input type="week"></input>
                        </fieldset>
                    </form>
                </section>
            </article>

            <aside>
                <address>
                    Mozilla Foundation
                    1981 Landings Drive
                    Building K
                    Mountain View, CA 94043-0801
                    USA
                </address>
            </aside>
        </main>

        <footer>

        </footer>

        <script src="./js/script.js"></script>
    </body>

</html>
```

## Folder Structure Example

```
- HTML
    - index.html
    - css
        - style.css
    - js
        - script.js 
    - img
        - logo.png
        - favicon.ico
        - elephant.png
```

[^1]: https://www.pluralsight.com/guides/semantic-html
[^2]: https://webflow.com/blog/html5-semantic-elements-and-webflow-the-essential-guide
[^3]: http://html5doctor.com/