#!/bin/bash

PastelVim='{
    "Ansi 0 Color" =         {
        "Blue Component" = 0.1490200;
        "Green Component" = 0.1490200;
        "Red Component" = 0.1490200;
    };
    "Ansi 1 Color" =         {
        "Blue Component" = 0.3764706;
        "Green Component" = 0.4235294;
        "Red Component" = 1;
    };
    "Ansi 10 Color" =         {
        "Blue Component" = 0.6727703;
        "Green Component" = 1;
        "Red Component" = 0.8094148;
    };
    "Ansi 11 Color" =         {
        "Blue Component" = 0.7996491;
        "Green Component" = 1;
        "Red Component" = 1;
    };
    "Ansi 12 Color" =         {
        "Blue Component" = 0.9982605;
        "Green Component" = 0.8627756;
        "Red Component" = 0.7116503;
    };
    "Ansi 13 Color" =         {
        "Blue Component" = 0.9965209;
        "Green Component" = 0.6133059;
        "Red Component" = 1;
    };
    "Ansi 14 Color" =         {
        "Blue Component" = 0.9970397;
        "Green Component" = 0.8763103;
        "Red Component" = 0.8759136;
    };
    "Ansi 15 Color" =         {
        "Blue Component" = 0.9372500;
        "Green Component" = 0.9372500;
        "Red Component" = 0.9372500;
    };
    "Ansi 2 Color" =         {
        "Blue Component" = 0.3764706;
        "Green Component" = 1;
        "Red Component" = 0.6588235;
    };
    "Ansi 3 Color" =         {
        "Blue Component" = 0.7137255;
        "Green Component" = 1;
        "Red Component" = 1;
    };
    "Ansi 4 Color" =         {
        "Blue Component" = 0.9960784;
        "Green Component" = 0.7960784;
        "Red Component" = 0.5882353;
    };
    "Ansi 5 Color" =         {
        "Blue Component" = 0.9921569;
        "Green Component" = 0.4509804;
        "Red Component" = 1;
    };
    "Ansi 6 Color" =         {
        "Blue Component" = 0.9960784;
        "Green Component" = 0.772549;
        "Red Component" = 0.7764706;
    };
    "Ansi 7 Color" =         {
        "Blue Component" = 0.9335317;
        "Green Component" = 0.9335317;
        "Red Component" = 0.9335317;
    };
    "Ansi 8 Color" =         {
        "Blue Component" = 0.4862745;
        "Green Component" = 0.4862745;
        "Red Component" = 0.4862745;
    };
    "Ansi 9 Color" =         {
        "Blue Component" = 0.6901961;
        "Green Component" = 0.7137255;
        "Red Component" = 1;
    };
    "Anti Alias" = 1;
    "Background Color" =         {
        "Blue Component" = 0.0980400;
        "Green Component" = 0.0980400;
        "Red Component" = 0.0980400;
    };
    Blur = 0;
    "Bold Color" =         {
        "Blue Component" = 0.5067359;
        "Green Component" = 0.5067359;
        "Red Component" = 0.9909502;
    };
    Columns = 120;
    "Cursor Color" =         {
        "Blue Component" = 0.3764706;
        "Green Component" = 0.6470588;
        "Red Component" = 1;
    };
    "Cursor Text Color" =         {
        "Blue Component" = 1;
        "Green Component" = 1;
        "Red Component" = 1;
    };
    "Disable Bold" = 0; 
    Font = "Monaco 13";
    "Foreground Color" =         {
        "Blue Component" = 0.6588200;
        "Green Component" = 1;
        "Red Component" = 0.3764700;
    };
    "Horizontal Character Spacing" = 1;
    NAFont = "Monaco 13";
    Rows = 24;
    "Selected Text Color" =         {
        "Blue Component" = 0.9476005;
        "Green Component" = 0.9476005;
        "Red Component" = 0.9476005;
    };
    "Selection Color" =         {
        "Blue Component" = 0.2117600;
        "Green Component" = 0.2235300;
        "Red Component" = 0.5137300;
    };
    Transparency = 0.1;
    "Vertical Character Spacing" = 1;
}'

# Add display profile
defaults write net.sourceforge.iTerm Displays -dict-add PastelVim "$PASTELVIM"
echo "PastelVim display profile added"

# Set the default display profile
#BOOKMARKS=`defaults read net.sourceforge.iTerm Bookmarks | sed 's/\("Display Profile" = \)"[^"]*";/\1"PastelVim";/'`
#defaults write net.sourceforge.iTerm Bookmarks "$BOOKMARKS"
#echo "PastelVim display profile installed as default"
