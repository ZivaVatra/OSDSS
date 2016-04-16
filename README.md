# OSDSS
Open Source Deep Sky Stacker

## Intro

So, back in 2012 I started work on an open source deep sky stacker. You can see the details (with example images) on the page here: http://www.ziva-vatra.com/index.php?aid=67&id=U29mdHdhcmU=


However dev stalled when I had to move to the city for work (the light pollution is so awful here that there is nothing to see at night but the moon and orange haze :-(  ). Now I have decided to push what I have done public, so it may be of use to others. 

I have included 12 sample images I took with my DSLR, which you can use as a refence to see how the noise reduction works. 
## Current versions:

### deepsky_stack_vers1.sh

A Bash script that (ab)uses panotools/enfuse/nona from the hugin project to align and fuse images together. 
To run, you do it as follows:  
<pre>deepsky_stack_vers1.sh ./sample_photos/*.tif</pre>
The result will be in your CWD with the name "deepsky_stack.tif".
You can compare the output to one of the sample_photos to see how much noise was reduced. 
Here is one I did earlier: http://www.ziva-vatra.com/index.php?aid=67&id=U29mdHdhcmU=


