# GitGPT

GitGPT is a small integration that simplifies the process of working with Git by allowing users to generate Git commands using natural language queries.

# Demo

![](https://s2.gifyu.com/images/ezgif.com-cropeffe3d4f0d054178.gif)

# Setup

```
chmod +x install.sh
./install.sh
```

This will copy gitgpt into your ```.zshrc``` file. Modify it accordingly if you are not a zsh user.

Make sure you have the OPENAI_API_KEY environment variable set. 

You can do so by running:

```export OPENAI_API_KEY=<your key here>```

Or by adding the above command to your .zshrc, or whatever other environment variable setup you prefer. 

# Run

```gitgpt <git-related question>```

You will be asked to confirm if you want to run the command or not.

## Thanks for being here

If you enjoyed this, you might like [CliGPT](https://github.com/Luanf/cligpt) - to get suggestions for general Linux commands.

