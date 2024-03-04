# Telegram File Uploader GitHub Action

This GitHub Action allows you to upload files from your GitHub repository to Telegram using Telethon. Perfect for sharing build artifacts, logs, or any files directly through Telegram messages.

## Inputs

### `to-who`
**Required** The recipient of the message (chat ID, username...).

### `message`
**Required** The message to send along with the files.

### `files`
**Required** The list of file paths to upload, separated by double slashes (`//`).

## Outputs

### `status`
The status of the command execution.

## Environment Variables

This action requires three environment variables to be set:
- `API_ID`: Your Telegram API ID.
- `API_HASH`: Your Telegram API hash.
- `BOT_TOKEN`: The Bot token.

You can obtain your `API_ID` and `API_HASH` from [my.telegram.org](https://my.telegram.org/), and the `BOT_TOKEN` from [BotFather](https://t.me/botfather) on Telegram.

## Example usage

This example demonstrates how to use the Telegram File Uploader action with the required inputs and environment variables.

Create a `.github/workflows/telegram-upload.yml` (or add to your existing workflow file):

```yaml
name: Upload Files to Telegram

on: [push]

jobs:
  upload-to-telegram:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v3
    
    - name: Upload files to Telegram
      uses: xz-dev/TelegramFileUploader@v1
      with:
        to-who: 'username'
        message: 'Here are your files!'
        files: 'path/to/file1//path/to/file2'
      env:
        API_ID: ${{ secrets.API_ID }}
        API_HASH: ${{ secrets.API_HASH }}
        BOT_TOKEN: ${{ secrets.BOT_TOKEN }}
        PRE_COMMAND: ""
```

Make sure to replace `your-github-username/telegram-file-uploader-action@v1` with the path to your action in your repository and the actual values of `to-who` and `files` inputs. Also, remember to set `API_ID`, `API_HASH`, and `BOT_TOKEN` in your repository's secrets.

And you can use the `PRE_COMMAND` environment variable to run a command before the action or override ENV variables. For example, you can use it to install the required dependencies before running the action:

```yaml
      env:
        API_ID: ${{ secrets.API_ID }}
        API_HASH: ${{ secrets.API_HASH }}
        BOT_TOKEN: ${{ secrets.BOT_TOKEN }}
        PRE_COMMAND: |
          OUTPUT="app/build/outputs/apk/debug/"
          export Debug=$(find $OUTPUT -name "*.apk")
```

---

This README provides a basic overview of your GitHub Action, how to use it, and how to configure it with necessary environment variables. Adjust the content according to your actual action's repository, inputs, and needs.

