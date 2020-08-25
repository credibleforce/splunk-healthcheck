# Splunk Engagement Healthcheck Tools

A set of tools for information gathering and summarziation of Splunk installations. Ideally these tools are used on a Distributed Monitoring Console for best results.

## Exporting Data

1. Download the latest [Splunk Engagement Healthcheck App](
https://github.com/mobia-security-services/splunk-engagement-healthcheck/releases/latest/download/engagement_healthcheck.tgz)

2. On the Distributed Monitoring Console install the Splunk Engagement Healthcheck app

3. To preview the saved searches that will be retrieved navigate to the Deployment Dashboard

4. To export the saved search data download the [Splunk Engagement Export Tool](https://github.com/mobia-security-services/splunk-engagement-healthcheck/releases/latest/download/engagement_export.zip)

5. Copy the archive to the Distributed Monitoring Console

6. Unzip the archive on the Distributed Monitoring Console `unzip engagement_export.zip`

7. Change directory to splunk_engagement_export `cd splunk_engagement_export`

8. Run the splunk_engagement_export.sh script as the splunk user to start the export `./splunk_engagement_export.sh`

9. The script assumes SPLUNK_HOME is located in /opt/splunk and pulls data from the past 24 hours. In the case either of these parameters need to be changed update the script.

10. Once complete the archive `engagement_data.tgz` will contain the results of the export

11. Copy the `engagement_data.tgz` archive from the Distributed Monitoring Console

## Analysis in Splunk

1. On your local Splunk instance install the [Splunk Engagement Healthcheck App](
https://github.com/mobia-security-services/splunk-engagement-healthcheck/releases/latest/download/engagement_healthcheck.tgz)

2. Copy the `engagement_data.tgz` archive to your local Splunk instance

3. As the Splunk user `sudo su - splunk` (or chown the extracted files to splunk user `chown -R splunk:splunk <extracted path>`)

3. Extract the data `tar -zxvf engagement_data.tgz`

4. Move `engagment_data` folder to a location on the local Splunk instance where Splunk will be able to read the files `mv engagment_data /var/customer-data/<customername>_engagement_name`

5. Login to Splunk

6. From the Apps menu choose Engagment Healthcheck

7. Under the Settings menu choose Data Input

8. Choose Monitor

9. Choose Files & Directories

10. Select Index Once and in the Browse to locate the path where the engagment data is found. 

11. Click Next.

12. Under Source type search for `engagement healthcheck` (note: for windows exported data utf16le version is required)

13. Under Index create a new index called `healthcheck`

14. Click Review and Submit.

15. In the Engagement Healthcheck app browse to the `engagement_healthcheck` dashboard

16. From the Report drop down choose the path for the imported data

17. Dashboard will populate.

18. Repeat process for each new customer data set.

## Producing offline HTML report

1. Copy the `engagement_data.tgz` archive to your local Splunk instance

2. As the Splunk user `sudo su - splunk` (or chown the extracted files to splunk user `chown -R splunk:splunk <extracted path>`)

3. Extract the data `tar -zxvf engagement_data.tgz`

4. Move `engagment_data` folder to a location on the local Splunk instance where Splunk will be able to read the files `mv engagment_data /var/customer-data/<customername>_engagement_name`

5. Download the latest [Report Builder](https://github.com/mobia-security-services/splunk-engagement-healthcheck/releases/latest/download/report_builder.tgz)

6. On your local Splunk instance upload and extract report_builder `tar -zxvf report_builder.tgz`

8. Run report_builder.py with the required options to produce the report `./report_builder.py -c "<CUSTOMER NAME>" -d <PATH TO CUSTOMER DATA> -b` (note: specifying the `-b` option produces a bundled report with no external data dependacies)

9. Once complete the resultant report will be located in `output/index.html`
