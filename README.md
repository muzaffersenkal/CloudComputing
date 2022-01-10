## About The Project

With the increase in IOT devices in recent years, digital twin technology plays an important role for companies.It is a virtual representation of the physical system [1].
It helps companies or organizations measure and visualize the performance of products in real time, as well as understand how they will perform in the future.

The Newcastle Urban Observatory has been gathering environmental data from IoT devices which are located in Newcastle-upon Tyne. This data is presented in a browser by making a 3D visualization of the city. These visualization images are not simple image, they contain over one trillion pixels called terapixel images [2]. It allows viewers to interactively zoom into incredible detail on big data at multiple scales. On these images, the data received from the sensors such as temperature, humidity are shown live. Terapixel visualizations is is a crucial computational cost, so the university has used Microsoft Azure cloud services to  perform the rendering process. Totally 1024 public cloud GPU nodes are used for this cost. 


It is very important to examine and monitor the performance of a running system. It determines the action to be taken so that the system can work better. It is useful not only to detect current performance issues, but also to identify other needs that may need improvement soon. Therefore, in this data mining project, the performance of the gpu-based system will be analyzed.

## Deliverables

-   Report file  => `reports/report.RMD` or `reports/report.pdf`.
-   Critical reflection report file => `reports/short_report.RMD` or `reports/short_report.pdf`.
-   Presentation =>  `docs/Presentation.pdf` or `docs/Presentation.pptx`.
-   Presentation video  =>  `docs/Presentation.mp4`.
-   Git Log file => `logs/210351491_GitLogFile.txt`.

## Getting Started

This is an example of how you may give instructions on setting up your project locally. To get a local copy up and running follow these simple example steps.


### Prerequisites

This is an example of how to list things you need to use the software and how to install them.

-   R

-   ProjectTemplate

    ``` sh
    install.packages('ProjectTemplate')
    ```
- Data

### Installation

1.  Clone the repo

    ``` sh
    git clone https://github.com/muzaffersenkal/CloudComputing
    ```
    
2.  Download Data [Link](https://github.com/NewcastleDataScience/StudentProjects202122/blob/master/TeraScope/Summary.md)


3.  Load Project

    ``` sh
    library('ProjectTemplate')
    load.project()
    ```
    
### Dasboard

1.  Run App

    ``` sh
    runApp('dashboard.R')
    ```

## Structure

After you enter the second line of code, you'll see a series of automated messages as ProjectTemplate goes about doing its work. This work involves:

-   Reading in the global configuration file contained in `config`.
-   Loading any R packages you listed in the configuration file.
-   Datasets stored in `data` or `cache`.
-   Preprocessing the data using the files in the `munge` directory.
-   Reports files are in the `reports` directory.
-   Analysis are in the `src` directory.

## Contributing

If you have a suggestion that would make this better, please fork the repo and create a pull request. You can also simply open an issue with the tag "enhancement".

1.  Fork the Project
2.  Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3.  Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4.  Push to the Branch (`git push origin feature/AmazingFeature`)
5.  Open a Pull Request

## Contact

Muzaffer Senkal - [email](mailto:mzffersenkal@gmail.com)

Project Link: <https://github.com/muzaffersenkal/CloudComputing/>
