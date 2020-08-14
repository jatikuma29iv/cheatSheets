# Mark Down Cheatsheet

## Formatting

| Style         | Syntax          |
|---------------|-----------------|
| **Bold**      | `**bold**`      |
| _Italics_     | `_Italics_`     |
| *BoldTtalics* | `*boldItalics*` |

To insert a `code text` in running text

```
To insert a `code text` in running text
```

## Indent
> Indent 1
>> Indent 2
>>> Indent 3

**Syntax**
```
> Indent 1
>> Indent 2
>>> Indent 3
```

## Creating tables

**Example**

| Left-aligned | Center-aligned | Right-aligned |
| :---         |     :---:      |          ---: |
| git status   | git status     | git status    |
| git diff     | git diff       | git diff      |


**Syntax**

```md
| Left-aligned | Center-aligned | Right-aligned |
| :\---        |     :---:      |          ---: |
| git status   | git status     | git status    |
| git diff     | git diff       | git diff      |
```


To include a pipe `|` as content within your cell, use a `\` before the pipe:
```md
| Name     | Character |
| ---      | ---       |
| Backtick | `         |
| Pipe     | \|        |
```

## Headings
> 
> # Heading1
> text
>
> ## Heading2
> text
> 
> ### Heading3
> text
> 
> #### Heading4
> text
>

**Syntax**
```
# Heading1
text
## Heading2
text
### Heading3
text
#### Heading4
```

## Adding `youtube` video link with image

```
[![VID DESC HERE](IMG_LINK_HERE)](VID_LINK)
```

### Details:
Each YouTube video has four generated images. They are predictably formatted as follows:

```
https://img.youtube.com/vi/<insert-youtube-video-id-here>/0.jpg
https://img.youtube.com/vi/<insert-youtube-video-id-here>/1.jpg
https://img.youtube.com/vi/<insert-youtube-video-id-here>/2.jpg
https://img.youtube.com/vi/<insert-youtube-video-id-here>/3.jpg
```
