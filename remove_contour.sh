#!/bin/bash

# This script was generated with the help of DeepSeek and is licensed under the MIT License.
# See LICENSE-SCRIPT file for full terms.

cd ~/Documents/RampartOne-Regular.ufo/glyphs

# Install required tools if needed
sudo apt-get install -y xmlstarlet bc

for glif in *.glif; do
    echo "Processing $glif..."
    
    # Backup original file
    cp "$glif" "${glif}.bak"
    
    # Find global extreme points
    extremes=$(xmlstarlet sel -t -m "//point" \
              -v "@x" -o " " -v "@y" -n "$glif" | awk '
    BEGIN {
        min_x = max_x = min_y = max_y = ""
    }
    {
        if (min_x == "" || $1 < min_x) min_x = $1
        if (max_x == "" || $1 > max_x) max_x = $1
        if (min_y == "" || $2 < min_y) min_y = $2
        if (max_y == "" || $2 > max_y) max_y = $2
    }
    END {
        print min_x, max_x, min_y, max_y
    }')
    
    read min_x max_x min_y max_y <<< "$extremes"
    
    # Find contour containing ALL extreme points
    contour_count=$(xmlstarlet sel -t -v "count(//contour)" "$glif")
    contour_to_remove=""
    
    for (( idx=1; idx<=contour_count; idx++ )); do
        points=$(xmlstarlet sel -t -m "//contour[$idx]/point" \
                 -v "@x" -o " " -v "@y" -n "$glif")
        
        has_min_x=0; has_max_x=0; has_min_y=0; has_max_y=0
        
        while read x y; do
            # Floating point comparison
            if [ $(echo "$x == $min_x" | bc -l) -eq 1 ]; then has_min_x=1; fi
            if [ $(echo "$x == $max_x" | bc -l) -eq 1 ]; then has_max_x=1; fi
            if [ $(echo "$y == $min_y" | bc -l) -eq 1 ]; then has_min_y=1; fi
            if [ $(echo "$y == $max_y" | bc -l) -eq 1 ]; then has_max_y=1; fi
        done <<< "$points"
        
        if [[ $has_min_x -eq 1 && $has_max_x -eq 1 && $has_min_y -eq 1 && $has_max_y -eq 1 ]]; then
            contour_to_remove=$idx
            break
        fi
    done
    
    # Remove the contour if found
    if [ -n "$contour_to_remove" ]; then
        echo "Removing contour $contour_to_remove containing extreme points"
        xmlstarlet ed -d "//contour[$contour_to_remove]" "$glif" > "${glif}.tmp"
        mv "${glif}.tmp" "$glif"
    else
        echo "No contour with all extreme points found"
        # Restore original if no changes
        rm "${glif}.bak"
    fi
done
