# Housebot

The Flashpoint Housebot

## Quick start

1. Install [Vagrant](https://www.vagrantup.com/)
1. Install [VirtualBox](https://www.virtualbox.org/)
1. `git clone https://github.com/litaio/development-environment.git lita-dev`
1. `cd lita-dev`
1. `vagrant up` - This will take a few minutes the first time.
1. `vagrant ssh`
1. `lita-dev`

After the last step, you will be dropped into a shell in a Debian system inside the `/home/lita/workspace` directory. This directory is shared with the "workspace" directory on your host computer inside the repository you cloned. The system has Redis, Ruby, and Lita already installed.

## Next steps

To run Lita:

    HOUSEBOT_SLACK_TOKEN='<token>' lita

To add a handler, just create a `.rb` file in the `handlers` directory. It will
automatically be loaded.

## License

[MIT](http://opensource.org/licenses/MIT)
