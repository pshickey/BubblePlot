#
# Authors: Adrianna Salazar, Patrick Hickey
#
# Prompts the user for the name of the csv file to be converted
# Reads the data and creates a format string to be used in Processing
# Writes the format string followed by all input lines to the output file
# Caveat: The first line of the file is assumed to be labels and is discarded
#

import re

def main():
    filename = input("Please enter the filename: ")
    in_file = open(filename, "r")
    outname = filename.rstrip("csv")+"sfd"
    out = open(outname, "w")
    text = in_file.read()
    text = text.split("\n")
    text.pop(0)
    line = text[0]
    format_str = ""
    num = re.compile('\d+\.?\d*')
    for token in line.split(","):
        if num.match(token) == None:
            format_str += "\","
        else:
            format_str += "%,"
    out.write(format_str.rstrip(",")+'\n')
    out.write('\n'.join(text))
    out.close()

if __name__ == '__main__':
    main()
