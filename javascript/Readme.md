# javascript

## Create Class

## Create Element

```javascript
var div = document.createElement('div');
div.textContent = "Sup, y'all?";
div.setAttribute('class', 'note');
document.body.appendChild(div);
```

Unfortunately, the textContent property used is not supported by all browsers. Internet Explorer (sad face) only supports an equivalent property called innerText. Other browsers support innerText too but in the interests of web standards it’s best to see which property the element supports, and use that:

```javascript
var span = document.createElement('span');
if (span.textContent) {
    span.textContent = "Hello!";
} else if (span.innerText) {
    span.innerText = "Hello!";
}
```

## Removing an element

```javascript
div.parentNode.removeChild(div);
```


## People to follow

[Malcolm Gladwell](https://www.google.com/search?q=malcolm+gladwell+outliers&oq=malcolm+gladwell+outliers&aqs=chrome..69i57j0l7.10191j0j7&sourceid=chrome&ie=UTF-8) - Outliners

[Douglas Kruger](https://www.google.com/search?q=douglas+kruger&oq=Douglas+Kruger&aqs=chrome.0.0l8.1840j0j7&sourceid=chrome&ie=UTF-8) - speaker - how to get rich, start business

