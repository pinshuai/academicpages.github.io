# Using Docker image on NERSC

Shifter is developed at NERSC and is used to create image (e.g., Docker image) to run on NERSC due to the reserved root permission. This [documentation](https://docs.nersc.gov/programming/shifter/how-to-use/) shows the steps to use Shifter to download and run the image. And this [docomentation](https://docs.nersc.gov/services/jupyter/#shifter-kernels-on-jupyter) shows how to run image in Jupyter.

## Download Docker image

Here we use an example image `ees16/tinerator:latest`.

```bash
shifterimg -v pull docker:ees16/tinerator:latest
```

To see a list of images,

```bash
shifterimg images
```

## Run image from the command line

To run the image from Cori command line,

```bash
shifter --image=ees16/tinerator:latest -e HOME=$HOME bash
```

