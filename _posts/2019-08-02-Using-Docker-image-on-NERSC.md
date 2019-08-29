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



## Run image on Jupyter

### Create kernel spec file

- create kernel spec file `kernel.json` and put it under `~/.local/share/jupyter/kernels/shifter-jupyter/kernel.json`
- Put the following in the `kernel.json` file

```json
{
 "argv": [
  "shifter",
  "-e",
  "HOME=/global/homes/p/pshuai",
  "--volume=/global/homes/p/pshuai/docker_files:/home/jovyan/work",
  "--image=ees16/tinerator:latest",
  "/opt/conda/bin/python",
  "-m",
  "ipykernel_launcher",
  "-f",
  "{connection_file}"
 ],
 "display_name": "shifter-jupyter",
 "language": "python"
}
```



### Mount volume

Before mounting any local volume to the container, do the following. 

```bash
setfacl -m u:nobody:x ~/ 
setfacl -m u:nobody:x ~/docker_files/ 
```

In this case, `~/docker_files` is open to anyone in the system.

###  launch Jupyter

- Go to [jupyter.nersc.gov](jupyter.nersc.gov) and login with username.
- Switch kernel to `shifter-jupyer`





# Use Docker on Mac

## install Docker 

First download Docker Desktop for Mac from [here](https://docs.docker.com/docker-for-mac/install/). Install the package on your mac.

## Download Docker image

Here we use `ees16/tinerator` as an example

```bash
docker pull ees16/tinerator
```

See all available images

```bash
docker images
```

## View the content of the image

```bash
docker run -it ees16/tinerator sh
```

## Lauch the image on Jupyter

```bash
docker run -v $PWD:/home/jovyan/work -p 8888:8888 ees16/tinerator:latest jupyter lab
```

Note to kill the processes which are using or listening to port 8888, do the following

```bash
lsof -i TCP:8888
kill <PID>
```

If the notebook does not open, try to paste one of the links (similar) to the browser (i.e.,`http://127.0.0.1:8888/?token=44dbc7fd4da2598a8797ff0657721b74589e9444315f5802` ).

```html
http://(a65d926e15ba or 127.0.0.1):8888/?token=44dbc7fd4da2598a8797ff0657721b74589e9444315f5802
```

