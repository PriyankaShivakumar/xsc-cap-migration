![Screenshot 2024-10-03 151235](https://github.com/user-attachments/assets/49cb8227-555f-4100-9f26-05a193f52a42)# Migration of SAP HANA XS Advanced To SAP Cloud Application Programming Model Using SAP HANA Application Migration Assistant

[![REUSE status](https://api.reuse.software/badge/github.com/SAP-samples/xsc-cap-migration)](https://api.reuse.software/info/github.com/SAP-samples/xsc-cap-migration)

## Description
The SAP HANA Application Migration Assistant allows users to migrate XS Advanced application to a CAP application with SAP HANA Cloud as a database. In this sample, only conversion of Source XSA database artifacts to the corresponding target CAP compliance database artifacts are listed.

## Introduction
SAP HANA Interactive Education or [SHINE](https://github.com/SAP-samples/hana-shine-xsa.git) is a demo application. It includes the following features: 
- **HDI Features:**
  - Table
  - HDBCDS Views
  - Sequence
  - Calculation Views
  - Associations
  - Table Functions
  - Synonyms
  - Procedures
  - Cross Container Access
  - Multiple Containers
  - Spatial Features
  - Local Time Data Generation
  - Comments for Tables
  - Index
  - Structured Privilege
  - Analytical Privilege
  - Usage of Table Functions in CDS views

SHINE follows the XS Advanced Programming Model(XSA) and uses SAP HANA on-premise for the database. This article describes the steps to be followed to Migrate this Demo Application from XSA to the Cloud Application Programming Model(CAP) with SAP HANA Cloud as the database using the SAP HANA Application Migration Assistant.

### Solution Diagram of SAP HANA Application Migration Assistant

<p align="center">
<img src="images\solutionDiagram.png">
</p>

## Requirements
- XSA on-premise database source system with the [SHINE](https://github.com/SAP-samples/hana-shine-xsa.git) content. Specifically the schema name of the deployed containers.
- SAP Business Technology Platform subaccount with `SAP Hana Cloud` and `SAP Hana Schemas and HDI Containers` service instances .
- SAP Business Application Studio Subscription.
- SAP Cloud Connector

## Where to Start
To successfully migrate the SHINE sample application using the SAP HANA Application Migration Assistant, follow the steps below:

1. Install and Configure the SAP Cloud Connector.
2. Setup an SAP BTP Destination to connect to the source system.
3. Create a SAP Business Application Studio Devspace with the SAP HANA Application Migration Assistant Extension installed.
4. Migrate using the SAP HANA Application Migration Assistant.
5. Post Migration Changes.
6. Deployment of the Migrated database artifacts.

#### **Note:** 
```
1. This sample covers only the migration of the database artifacts from SAP Neo Database to SAP Hana Cloud.
2. The migration steps should be tested in a development environment before production.
```

## Steps
## Step-1: Install and Configure the SAP Cloud Connector

1. Install the [SAP Cloud Connector](https://tools.hana.ondemand.com/#cloud) on your local system. For the installation and setup of the cloud connector, please refer to this [Documentation](https://help.sap.com/docs/connectivity/sap-btp-connectivity-cf/installation?locale=en-US).  
  
2. After installing the cloud connector, you can access it by opening your web browser and going to `https://localhost:<port-no>/`. Use your credentials to log in.
   
3. Once you've successfully logged in, you should set up two connections in the Cloud Connector.
   -  The first connection should link to the subaccount with the source database, and the second connection should be for the target subaccount with the SAP Hana Cloud. To establish these connections, click on the connector button in the left menu. 

   -  Now, enter the necessary details for your subaccount - this includes the Region, Subaccount ID, Display Name, Subaccount User, Password, and Location ID. After entering all the information, click on 'Save'.

<p align="center">
	<img src="images\destination1.png" width="600" height="400">
</p>

4. Select the subaccount where the source database is located, then add a service channel under 'on-prem to cloud' using the following details:  
	
   - **Type**: HANA Database
	
   - **HANA Instance Name**: < DB/Schema ID >
	
   - **Local Instance Number**: Input any two-digit number between 00 and 09. This number is used to compute the port number needed to access the SAP instance in the Hana Cloud. The local port is calculated from the local instance number (3<n<15). For example, if the number is 7, then the local port would be 30715.
	
   - **Connections**: 1

<p align="center">
	<img src="images\destination2.png" width="600" height="400">
</p>

5. In the SAP Business Technology Platform (BTP) Cloud Foundry account where the Business Application Studio (BAS) subscription is created, select 'Cloud to On-Prem' and add a mapping with the following details:  
	
   - **Back-end Type**: SAP Hana  
	
   - **Protocol**: TCP  
	
   - **Internal Host**: localhost  
	
   - **Internal Port**: < portno > (The port number derived from your local instance number)  
	
   - **Virtual Host**: myvirtualhost  
	
   - **Virtual Port**: This should be the same as your internal port
	
   - **Principal Type**: None  
		
<p align="center">
	<img src="images\destination3.png" width="600" height="400">
</p>
	
## Step-2: Setup an SAP BTP Destination to connect to the source system
  
Navigate to the BTP Cloud Foundry subaccount and select 'Destination' under 'Connectivity' from the left menu pane. Create a new destination using the following details:
 
 - **Name**: < Destination name >
 - **Type**: HTTP
 - **URL**: `https://<virtual-host>:<virtual-port-no>/`
 - **ProxyType**: on-premise
 - **Authentication**: NoAuthentication
 - **Locationid**: Location id as mentioned in cloud connector

And the following additional properties: 
 - **HTML5.DynamicDestination** : true
 - **WebIDEEnabled** : true
 - **WebIDEUsage** : xs_hdb 
	
<p align="center">
	<img src="images\destination4.png" width="600" height="400">
</p>

## Step-3: Create a SAP Business Application Studio Devspace with the SAP HANA Application Migration Assistant Extension installed  
	
1. In the sub-account where you created the destination, establish a subscription to SAP Business Application Studio (BAS).

2. Open the BAS from the subscription and select "Create Dev Space". Assign a desired name to your Dev Space and select the "Full Stack Cloud Application" type. Then, choose the `SAP HANA Application Migration Assistant` Extension to help with migration. Finally, click on "Create Dev Space".
   
3. Wait for the status of your newly created Dev Space to change to "Running". Once it's running, you can open it by clicking on the name of the Dev space that you just created.
   
4. Navigate to the folder by clicking on File -> Open Folder. Enter the path `/home/user/projects/` and click on OK.
   
5. Clone the XSA Source application to this folder using the Terminal.
   
6. Once the folder opens, you can select the SAP HANA Application Migration Assistant from the Command Palette (You can access the Command Palette from View -> Command Palette).

## Step-4: Migrate using the SAP HANA Application Migration Assistant

1. Open the the Command Palette and type "SAP HANA Application Migration Assistant" and select the command when it appears.
	
2. When the Migration Assistant Wizard opens, select the migration path. Since we are migrating from XSA to CAP, select `XSA to CAP` as your migration path.		

<p align="center">
  <img width="536" alt="HomeScreen" src="images\homescreen.png">
</p>


3. In the Data Source page of the wizard, choose the destination you previously created from the dropdown menu. 
	
<p align="center">
  <img width="544" alt="DestinationList" src="images\destinationList.png">
</p>

4. Enter the user credentials for the SAP HANA Database Migration User - username and password - into their respective fields. Hit the login button to authorize these credentials.[Procedure to create migration user](https://help.sap.com/docs/SAP_HANA_PLATFORM/58d81eb4c9bc4899ba972c9fe7a1a115/2786447387df41f69a0dad1cc2973e95.html#procedure)
	
<p align="center">
<img width="545" alt="Login" src="images\login.png">
</p>

5. To proceed, click on the Next button.  
		
<p align="center">
<img width="545" alt="LoggedIn" src="images\loginEnabled.png">
</p>

6. In the "Source Type" page, select your cloned project from the drop down. In this case, its `hana-shine-xsa`.

<p align="center">
<img width="545" alt="selectType" src="images\selectType.png">
</p>
  
7. Select the DB Folders(It can be multiple). In this case it will be `core-db` and `user-db`.

<p align="center">
<img width="545" alt="DU1" src="images\DeliveryUnit1.png">
</p>

8. Choose the target directory. This is where the migration results will be stored.
   
   **Note:** Ensure that the directory you select is a sub-directory of `/home/user/projects`.	

<p align="center">
<img width="545" alt="DU2" src="images\DeliveryUnit2.png">
</p>

9. Specify a unique name for the Target Folder, where the migration results will be saved. Once you've entered the name, click on Next.

<p align="center">
<img width="545" alt="end" src="images\DeliveryUnit3.png">
</p>

10. In the "Schema" page, Enter the schema name of the containers, Once entered, click on Finish.

10. Once you see the pop-up notification at the bottom right corner of your screen, it means that the migration process is underway. This notification will keep you updated on all the steps that follow. At the end of the process, a CAP project with the revised database artifacts will be created. Additionally, a `report.html` file will be generated within the project. This file contains detailed information about your project's migration.

<p align="center">
<img width="545" alt="end" src="images\end.png">
</p>

## Step-5: Post Migration Changes
Once the project is created, there are some adjustments we need to make manually as these are not currently handled by the Assistant.
 1. For the HCO_DEMOCONTENT project, make the following changes:
    - Delete the unsupported_feature folder from core-db/src/data folder.
    - Delete `synonyms/sys_rt.hdbsynonym` from core-db/src folder.
    - In the `core-db/cds/data/MDViews.cds` file, alias needs to be modified. So ![Product_Id] and ![Product_Name] or ![ProductName] should be changed to PRODUCTID and PRODUCTNAME respectively as they are defined like this in the entity definations. You can refer the log file in the logs folder for the line number for these changes.
    - Replace the code in the mta.yaml with the below code. Replace <Project Name> with the name of your project.
   
      ```
      _schema-version: 3.3.0
      ID: <Project Name>
      version: 1.0.0
      description: A migrated CAP Project.
      parameters:
        enable-parallel-deployments: true
      build-parameters:
        before-all:
          - builder: custom
            commands:
              - npm ci
              - npx cds build --production
      modules:
        - name: <Project Name>-deployer0
          type: hdb
          path: gen/core-db
          deployed-after:
            - <Project Name>-deployer1
          parameters:
            buildpack: nodejs_buildpack
          requires:
            - name: <Project Name>-db0
              properties:
                TARGET_CONTAINER: ~{hdi-container-name}
            - name: <Project Name>-db1
              group: SERVICE_REPLACEMENTS
              properties:
                key: hdi-user-service
                service: ~{user-container-name}
        - name: <Project Name>-deployer1
          type: hdb
          path: gen/user-db
          parameters:
            buildpack: nodejs_buildpack
          requires:
            - name: <Project Name>-db1
      resources:
        - name: <Project Name>-db0
          type: com.sap.xs.hdi-container
          parameters:
            service: hana
            service-plan: hdi-shared
          properties:
            hdi-container-name: ${service-name}
        - name: <Project Name>-db1
          type: com.sap.xs.hdi-container
          parameters:
            service: hana
            service-plan: hdi-shared
            service-name: Test-db1
          properties:
            user-container-name: ${service-name}
      ```
 2. Currently, changes to Flowgraph, Reptask, and Replication artifacts are not covered. You will need to modify these manually. Unsupported types and functions in the calculation view such as "CE_FUNCTION", "CACHE", etc., need to be noted. Please refer to the [HANA Cloud Documentation](https://help.sap.com/docs/hana-cloud/sap-hana-cloud-overview-guide/sap-hana-cloud-overview-guide) for more details on how to handle these.
    
## Step-6: Deployment of the Migrated database artifacts.

1. Using the Terminal, navigate to the root of the target folder.
   
2. Right click on the mta.yaml and select `Build MTA Project`.
   
3. Next, log in to your Cloud Foundry account using the following steps:

   - Open a new terminal in the Business Application Studio
   - Run the command `cf login -a < API_URL >` and input your username and password

5. Right click on the mtar file inside mta_archives folder and select `Deploy MTA Archive`.

## Step-7: Data Migration Configuration.

Migrating from SAP HANA database to SAP HANA Cloud requires a dedicated user in your SAP HANA source database.
A dedicated user is required for the migration to run for which the user must be created or necessary privileges must be granted to an existing user in your SAP HANA source database. Follow the below steps to assign privileges:

1. Open the SQL Console.

2. (optional) Create a data migration user by executing the following statement:
   
   **Note:** Before executing the statement, replace <password> with a password that complies with the default SAP HANA password policy. It must have at least 8 characters and comprise at least one uppercase letter, atleast one lowercase letter and atleast one number.
   
   ```
   CREATE USER <username> PASSWORD <password> NO FORCE_FIRST_PASSWORD_CHANGE;
   ```

3. Grant the necessary privileges to the data migration user. To do that, run the following the script in an SQL Console:

   ```
   GRANT SELECT ON _SYS_REPO.DELIVERY_UNITS TO <username>;
   GRANT SELECT ON _SYS_REPO.ACTIVE_OBJECT TO <username>; 
   GRANT CATALOG READ TO <username>;
   GRANT INIFILE ADMIN TO <username>;
   GRANT TRUST ADMIN TO <username>;
   GRANT CERTIFICATE ADMIN TO <username>;
   GRANT CREATE REMOTE SOURCE TO <username>;
   GRANT EXPORT TO <username>;
   GRANT EXECUTE ON SYS.EXPORT_CATALOG_FOR_MIGRATION_DEV TO <username>;
   DO BEGIN
   	SELECT * FROM PUBLIC.M_SERVICES WHERE SERVICE_NAME = 'diserver';
   	IF ::ROWCOUNT != 0
   	THEN
   		EXEC 'CREATE LOCAL TEMPORARY TABLE #PRIVILEGES LIKE _SYS_DI.TT_API_PRIVILEGES';
   		EXEC 'INSERT INTO #PRIVILEGES (PRINCIPAL_NAME, PRIVILEGE_NAME, OBJECT_NAME) SELECT ''<username>'', PRIVILEGE_NAME, OBJECT_NAME FROM _SYS_DI.T_DEFAULT_DI_ADMIN_PRIVILEGES';
   		EXEC 'CALL _SYS_DI.GRANT_CONTAINER_GROUP_API_PRIVILEGES_WITH_GRANT_OPTION(''_SYS_DI'', #PRIVILEGES, _SYS_DI.T_NO_PARAMETERS, ?, ?, ?)';
   		EXEC 'DROP TABLE #PRIVILEGES';
   		EXEC 'GRANT SELECT ON _SYS_DI.TT_API_PRIVILEGES to <username>';
   		EXEC 'GRANT SELECT ON _SYS_DI.T_DEFAULT_CONTAINER_GROUP_ADMIN_PRIVILEGES to <username>';
   		EXEC 'GRANT SELECT ON _SYS_DI.T_NO_PARAMETERS to <username>';
   	END IF;
   END;
   GRANT SELECT ON SCHEMA _SYS_STATISTICS TO <username>;
   GRANT SELECT ON SCHEMA _SYS_BI TO <username>;
   ```

Once the necessary privileges are assigned, follow the below steps:

1. Open the Command palette and type, “SAP HANA Application Migration Assistant” and select the command when it appears.

<p align="center">
<img src="https://github.com/user-attachments/assets/ed606d81-0fe1-4a8e-9f76-74b23353a7e4" width="700" height="150">
</p>


2. When the migration wizard opens, select the Data Migration Configuration Template as shown below:

<p align="center">
<img src="https://github.com/user-attachments/assets/2760918b-fe28-41d4-bd25-509bf3b2dff4" width="600" height="400">
</p>


3. In the Data Source Page of the wizard, choose the destination that you previously created from the Dropdown menu as shown below:

<p align="center">
<img src="https://github.com/user-attachments/assets/d5d64582-5892-4e08-93a2-d4749ae33d33" width="600" height="400">
</p>


4. Enter the user credentials for the SAP HANA Database Migration User – username and password – into their respective fields. Hit the login button to authorize these credentials

<p align="center">
<img src="https://github.com/user-attachments/assets/7ceb71f7-efd9-4f8b-bdeb-e5d40cdd9cdd" width="600" height="400">
</p>


5. To proceed, click on the next button

6. In the Data Migration Configuration Page of the wizard, select the Data migration configuration sql file from the drop down menu, which would have been created as part of your migrated projects.

<p align="center">
<img src="https://github.com/user-attachments/assets/efbdfddb-8dc8-4d79-a3bb-e941dfe016c9" width="600" height="400">
</p>


7. Enter the Hana cloud target schema in the next field

8. In the next field as shown below, enter the data migration user name which was created earlier and for which the necessary privileges were granted. Make sure the user already exists else a error message will be thrown to create the user and assign necessary privileges

<p align="center">
<img src="https://github.com/user-attachments/assets/9d82e310-8827-4653-bce5-ef2bf6f1405e" width="600" height="400">
</p>

9. Click on the finish button.




## Features Currently supported in SAP HANA Application Migration Assistant:
For a detailed list of the features supported by the SAP HANA Application Migration Assistant, please refer to [this](supportedFeatures.md) link.

## Features that are currently out of scope in SAP HANA Application Migration Assistant:

1. Converting xsodata into cap service definition
   
2. Converting “xsjs”,”xsjslib” into cap nodejs
   
3. Creating proxy cds for cross container schema
   
4. Following Artifacts are not currently supported '.hdbreptask', '.hdbvirtualtable', '.hdbflowgraph'


## Learning Resources
1. [The Self-Service Migration Tool for SAP HANA Cloud](https://help.sap.com/docs/hana-cloud/sap-hana-cloud-migration-guide/self-service-migration-for-sap-hana-cloud-tool).
2. [SAP HANA Cloud, SAP HANA Database Developer Guide for Cloud Foundry Multitarget Applications (SAP Business App Studio)](https://help.sap.com/docs/hana-cloud-database/sap-hana-cloud-sap-hana-database-developer-guide-for-cloud-foundry-multitarget-applications-sap-business-app-studio/sap-hana-cloud-sap-hana-database-developer-guide-for-cloud-foundry-multitarget-applications-sap-business-app-studio)

## How to obtain support
[Create an issue](https://github.com/SAP-samples/xsc-cap-migration/issues) in this repository if you find a bug or have questions about the content.
 
For additional support, [ask a question in SAP Community](https://answers.sap.com/questions/ask.html).

## License
Copyright (c) 2024 SAP SE or an SAP affiliate company. All rights reserved. This project is licensed under the Apache Software License, version 2.0 except as noted otherwise in the [LICENSE](LICENSE) file.
