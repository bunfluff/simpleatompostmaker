# <p align="center">simple atom post maker</p>

<p align="center">
  <img src="picture.png" alt="preview of the script in the linux cli"/>
</p>
it's what the title says! sapm (acronym) is written in bash by someone who knows way too little about bash
    
## 🛠️ features 
- generates an atom post*
- automatic and manual mode
- swappable `content.html` for easier post making
- template file so you can easily create one of your own

> *you still need to copy and paste it to your atom file

## requirements
- be running linux
- be running macos (untested)
- be running windows with bash support (untested)

## 💡 usage
### automatic setup
1. customize `configs/auto.conf`*
2. place your text post content into `content.html`
3. configure your `configs/atom.tpl`
4. run `atom.sh` and select option `1`
5. copy the contents of `output/out.txt` to your `.atom` file

## manual setup
1. make your `configs/content.html`
2. configure your `configs/atom.tpl`
3. run `atom.sh` and select option `2`
4. go through the setup
5. copy the contents of `output/out.txt` to your `.atom` file

### 💻️ about `content.html`
i decided to use a `.html` since it still allowed me to see if the syntax was correct. please still format it to xhtml standarts, or else the feed readers will freak out. keep in mind the syntax the readers accept, as well

### ⚙️ about `atom.tpl`
this is your atom template! configure to your heart's content. there's a single element you **will** need to customize, which is the `<id>` tag.
i have it set up as this string:

```
tag:example.com,${IDDATE}:/blog-${ID}
```
which, with the data included on `configs/auto.conf`, would look like this:
```
tag:example.com,2000-01-01:/blog-test
```
my template is the following:
- always start with `tag:`
- after tag, goes the site's url
- after the first `/`, goes a `,` and today's date in `yyyy-mm-dd` format, followed by a `:`
- page name, in the example above `/blog`, goes after the date
- then `-` and the post id
  
## 🍰 contributing    
contributions are greatly appreciated since this might work on your end, especially if you're on macos or windows
        
## ➤ license
distributed under the MIT license. see [LICENSE](LICENSE) for more information.
        