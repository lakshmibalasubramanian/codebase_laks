CellProfiler Pipeline: http://www.cellprofiler.org
Version:1
SVNRevision:10997

LoadImages:[module_num:1|svn_version:\'10951\'|variable_revision_number:11|show_window:True|notes:\x5B"Load the images by matching files in all folders against the text pattern \'GFPHistone\'. Use regular expressions to match and name metadata in the file and path names. Group the analysis by \'Run\' so that each folder is analyzed separately. "\x5D]
    File type to be loaded:individual images
    File selection method:Text-Exact match
    Number of images in each group?:3
    Type the text that the excluded images have in common:Do not use
    Analyze all subfolders within the selected folder?:All
    Input image file location:Default Input Folder\x7C.
    Check image sets for missing or duplicate files?:Yes
    Group images by metadata?:No
    Exclude certain files?:No
    Specify metadata fields to group by:Run
    Select subfolders to analyze:
    Image count:1
    Text that these images have in common (case-sensitive):Ecad
    Position of this image in each group:(cherry)
    Extract metadata from where?:None
    Regular expression that finds metadata in the file name:^(?P<Stain>.*)_(?P<Frame>\x5B0-9\x5D*)
    Type the regular expression that finds metadata in the subfolder path:.*\x5B\\\\/\x5D(?P<Run>.*)$
    Channel count:1
    Group the movie frames?:No
    Grouping method:Interleaved
    Number of channels per group:2
    Load the input as images or objects?:Images
    Name this loaded image:Origimage
    Name this loaded object:Nuclei
    Retain outlines of loaded objects?:No
    Name the outline image:NucleiOutlines
    Channel number:1
    Rescale intensities?:Yes

CorrectIlluminationCalculate:[module_num:2|svn_version:\'10458\'|variable_revision_number:2|show_window:True|notes:\x5B\x5D]
    Select the input image:Origimage
    Name the output image:maskcalc
    Select how the illumination function is calculated:Background
    Dilate objects in the final averaged image?:No
    Dilation radius:1
    Block size:20
    Rescale the illumination function?:No
    Calculate function for each image individually, or based on all images?:Each
    Smoothing method:No smoothing
    Method to calculate smoothing filter size:Automatic
    Approximate object size:10
    Smoothing filter size:10
    Retain the averaged image for use later in the pipeline (for example, in SaveImages)?:No
    Name the averaged image:IllumBlueAvg
    Retain the dilated image for use later in the pipeline (for example, in SaveImages)?:No
    Name the dilated image:IllumBlueDilated
    Automatically calculate spline parameters?:Yes
    Background mode:auto
    Number of spline points:5
    Background threshold:2
    Image resampling factor:2
    Maximum number of iterations:40
    Residual value for convergence:0.001

CorrectIlluminationApply:[module_num:3|svn_version:\'10300\'|variable_revision_number:3|show_window:True|notes:\x5B\x5D]
    Select the input image:Origimage
    Name the output image:illumoutline
    Select the illumination function:maskcalc
    Select how the illumination function is applied:Subtract

EnhanceOrSuppressFeatures:[module_num:4|svn_version:\'10591\'|variable_revision_number:2|show_window:True|notes:\x5B\x5D]
    Select the input image:illumoutline
    Name the output image:Enhanced_image
    Select the operation:Enhance
    Feature size:15
    Feature type:Neurites
    Range of hole sizes:1,10

Smooth:[module_num:5|svn_version:\'10465\'|variable_revision_number:1|show_window:True|notes:\x5B\x5D]
    Select the input image:Enhanced_image
    Name the output image:FilteredImage
    Select smoothing method:Gaussian Filter
    Calculate artifact diameter automatically?:No
    Typical artifact diameter, in  pixels:15
    Edge intensity difference:0.1

ImageMath:[module_num:6|svn_version:\'10718\'|variable_revision_number:3|show_window:True|notes:\x5B\x5D]
    Operation:Invert
    Raise the power of the result by:1
    Multiply the result by:1
    Add to result:0
    Set values less than 0 equal to 0?:Yes
    Set values greater than 1 equal to 1?:Yes
    Ignore the image masks?:No
    Name the output image:Invertedimage
    Image or measurement?:Image
    Select the first image:FilteredImage
    Multiply the first image by:1
    Measurement:
    Image or measurement?:Image
    Select the second image:
    Multiply the second image by:1
    Measurement:

IdentifyPrimaryObjects:[module_num:7|svn_version:\'10826\'|variable_revision_number:8|show_window:True|notes:\x5B\'Identify the fly embryos from the histone stain image. Three-class thresholding works better than the default two-class method.\'\x5D]
    Select the input image:Invertedimage
    Name the primary objects to be identified:Cells
    Typical diameter of objects, in pixel units (Min,Max):50,175
    Discard objects outside the diameter range?:Yes
    Try to merge too small objects with nearby larger objects?:Yes
    Discard objects touching the border of the image?:Yes
    Select the thresholding method:MoG Global
    Threshold correction factor:1.0
    Lower and upper bounds on threshold:0.01,1.0
    Approximate fraction of image covered by objects?:0.9
    Method to distinguish clumped objects:Intensity
    Method to draw dividing lines between clumped objects:Intensity
    Size of smoothing filter:10
    Suppress local maxima that are closer than this minimum allowed distance:25
    Speed up by using lower-resolution image to find local maxima?:Yes
    Name the outline image:celledges
    Fill holes in identified objects?:Yes
    Automatically calculate size of smoothing filter?:Yes
    Automatically calculate minimum allowed distance between local maxima?:No
    Manual threshold:0.0
    Select binary image:Otsu Global
    Retain outlines of the identified objects?:Yes
    Automatically calculate the threshold using the Otsu method?:Yes
    Enter Laplacian of Gaussian threshold:.5
    Two-class or three-class thresholding?:Three classes
    Minimize the weighted variance or the entropy?:Weighted variance
    Assign pixels in the middle intensity class to the foreground or the background?:Background
    Automatically calculate the size of objects for the Laplacian of Gaussian filter?:Yes
    Enter LoG filter diameter:5
    Handling of objects if excessive number of objects identified:Continue
    Maximum number of objects:500
    Select the measurement to threshold with:None

SaveImages:[module_num:8|svn_version:\'10822\'|variable_revision_number:7|show_window:True|notes:\x5B\x5D]
    Select the type of image to save:Objects
    Select the image to save:None
    Select the objects to save:Cells
    Select the module display window to save:None
    Select method for constructing file names:From image filename
    Select image name for file prefix:Origimage
    Enter single file name:OrigBlue
    Do you want to add a suffix to the image file name?:Yes
    Text to append to the image name:objects
    Select file format to use:mat
    Output file location:Default Output Folder\x7CNone
    Image bit depth:8
    Overwrite existing files without warning?:No
    Select how often to save:Every cycle
    Rescale the images? :No
    Save as grayscale or color image?:Grayscale
    Select colormap:gray
    Store file and path information to the saved image?:No
    Create subfolders in the output folder?:No

TrackObjects:[module_num:9|svn_version:\'10629\'|variable_revision_number:4|show_window:False|notes:\x5B\x5D]
    Choose a tracking method:Overlap
    Select the objects to track:Cells
    Select object measurement to use for tracking:None
    Maximum pixel distance to consider matches:20
    Select display option:Color and Number
    Save color-coded image?:Yes
    Name the output image:TrackedCells
    Select the motion model:Both
    Number of standard deviations for search radius:3
    Search radius limit, in pixel units (Min,Max):2.000000,10.000000
    Run the second phase of the LAP algorithm?:Yes
    Gap cost:40
    Split alternative cost:40
    Merge alternative cost:40
    Maximum gap displacement:50
    Maximum split score:50
    Maximum merge score:50
    Maximum gap:5
