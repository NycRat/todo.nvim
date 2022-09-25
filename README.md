# todo.nvim

Neovim Plugin that opens global todo files from any directory.

## Usage

### :TodoOpen ```<file>```

Opens/Creates todo file at ```todo_path/<file>```  
Opens ```todo_path/todo.txt``` if ```<file>``` not specified  
Opens file with ```default_file_extension``` if extension not specified  
Example ```:TodoOpen school``` opens school.txt

## Configuration

### Default Config

```
require("todo").setup({
  default_file_extension = ".txt"
})
```

