# frozen_string_literal: true

module AsciiArt
  HANGMAN = [
    '
           +----+
                |
                |
                |
                |
                |
       ===========
    ',
    '
           +----+
                |
           O    |
                |
                |
                |
       ===========
    ',
    '
           +----+
                |
           O    |
           |    |
                |
                |
       ===========
    ',
    '
           +----+
                |
           O    |
          /|    |
                |
                |
       ===========
    ',
    '
           +----+
                |
           O    |
          /|\   |
                |
                |
       ===========
    ',
    '
           +----+
                |
           O    |
          /|\   |
          /     |
                |
       ===========
    ',
    '
           +----+
                |
           O    |
          /|\   |
          / \   |
                |
       ===========
    ',
    '
           +----+
           |    |
           O    |
          /|\   |
          / \   |
                |
       ===========
    '
  ].freeze

  TITLE = <<~TITLE
    ██╗  ██╗ █████╗ ███╗   ██╗ ██████╗ ███╗   ███╗ █████╗ ███╗   ██╗
    ██║  ██║██╔══██╗████╗  ██║██╔════╝ ████╗ ████║██╔══██╗████╗  ██║
    ███████║███████║██╔██╗ ██║██║  ███╗██╔████╔██║███████║██╔██╗ ██║
    ██╔══██║██╔══██║██║╚██╗██║██║   ██║██║╚██╔╝██║██╔══██║██║╚██╗██║
    ██║  ██║██║  ██║██║ ╚████║╚██████╔╝██║ ╚═╝ ██║██║  ██║██║ ╚████║
    ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝ ╚═════╝ ╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝
  TITLE
end
