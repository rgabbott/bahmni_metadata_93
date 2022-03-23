# Yekatit_metadata
Yekatit metadata for configuration
Introduction
The Initializer module is an API-only module that processes the content of the configuration folder when it is found inside OpenMRS' application data directory:

.
├── modules/
├── openmrs.war
├── openmrs-runtime.properties
├── ...
└── configuration/
The configuration folder is subdivided into domain subfolders:

configuration/
  ├── addresshierarchy/
  ├── appointmentsspecialities/
  ├── appointmentsservicesdefinitions/
  ├── attributetypes/
  ├── autogenerationoptions/
  ├── bahmniforms/
  ├── conceptclasses/
  ├── concepts/
  ├── datafiltermappings/
  ├── drugs/
  ├── encountertypes/
  ├── globalproperties/
  ├── htmlforms/
  ├── idgen/
  ├── jsonkeyvalues/
  ├── locations/
  ├── locationtags/
  ├── messageproperties/
  ├── metadatasetmembers/ 
  ├── metadatasets/ 
  ├── metadatasharing/ 
  ├── metadatatermmappings/ 
  ├── patientidentifiertypes/ 
  ├── personattributetypes/ 
  ├── privileges/ 
  ├── programs/ 
  ├── programworkflows/
  ├── programworkflowstates/
  └── roles/
   
Each domain-specific subfolder contains the metadata and configuration information that is relevant to the subfolder's domain. Although several file types are supported for providing metadata, CSV files are the preferred format and all domain should aim at being covered through parsing CSV files.

Objectives
This module loads an OpenMRS configuration consisting of OpenMRS metadata.
CSV files are the preferred format, however a number of metadata domains rely on other file formats. See the list below for details.
Initializer processes all configuration files upon starting up.
Initializer produces a checksum file for each processed file. A file will never be processed again until its checksum has changed.
See more info here about checksums.
Each line of those CSV files represents an OpenMRS object to be created, edited or retired.
Each line of those CSV files follows the WYSIWYG principle.
Supported domains and default loading order
We suggest to go through the following before looking at specific import domains:

Conventions for CSV files
This is the list of currently supported domains in respect to their loading order:

Message properties key-values (.properties files)
Generic JSON key-values (JSON files)
Metadata Sharing packages (ZIP files)
Visit Types (CSV files)
Patient identifier types (CSV files)
Privileges (CSV files)
Encounter Types (CSV files)
Roles (CSV files)
Global Properties (XML files)
Attribute Types (CSV files)
Locations (CSV files)
Location Tags (CSV files)
Bahmni Forms (JSON Files)
Concept Classes (CSV files)
Concepts (CSV files)
Programs (CSV files)
Program Worklows (CSV files)
Program Worklow States (CSV files)
Person Attribute Types (CSV files)
Identifier Sources (CSV files)
Autogeneration Options (CSV files)
Drugs (CSV files)
Order Frequencies (CSV files)
Order Types (CSV files)
Bahmni Appointments Specialities (CSV files)
Bahmni Appointments Service Definitions (CSV files)
Data Filter Entity-Basis Mappings (CSV files)
Metadata Sets (CSV files)
Metadata Set Members (CSV files)
Metadata Term Mappings (CSV files)
HTML Forms (XML files)
How to try it out?
Build the master branch and install the built OMOD to your OpenMRS instance:

git clone https://github.com/mekomsolutions/openmrs-module-initializer/tree/master
cd openmrs-module-initializer
mvn clean package
Runtime requirements & compatibility
OpenMRS Core 2.1.1 (required)
HTML Form Entry (compatible)
ID Gen 4.3 (compatible)
Metadata Sharing 1.2.2 (compatible)
Metadata Mapping 1.3.4 (compatible)
Bahmni Appointments 1.2-beta (compatible)
Data Filter 1.0.0 (compatible)
Bahmni I.e Apps 1.0.0 (compatible)
How to test out your OpenMRS configs?
See the Initializer Validator README page.

Finer control of domains loading at app runtime
See the documentation on Initializer's runtime properties.

Quick facts
Initializer enables to achieve the OpenMRS backend equivalent of Bahmni Config for Bahmni Apps. It facilitates the deployment of implementation-specific configurations without writing any code, by just filling the configuration folder with the needed metadata and in accordance to Initializer's available implementations.

Get in touch
On OpenMRS Talk

Sign up, start a conversation and ping us with the mention @MekomSolutions in your message.
On Slack:

Join the Initializer channel and ping us with a @Mekom mention.
Report an issue
https://github.com/mekomsolutions/openmrs-module-initializer/issues

Releases notes
Version 2.1.0
Initialize Validator a standalone fatjar to make dry runs of OpenMRS configs.
Nested structures of configuration files are supported.
Added a runtime property to define an inclusion or exclusion list of domains.
Added a runtime property to specify wildcard patterns filters for each domain.
Added a runtime property to toggle off the generation of the checksums.
Improved logging output with ASCII Tables for Java.
Bulk creation and edition of ID Gen's autogeneration options provided through CSV files in configuration/autogenerationoptions.
Support associating location tags to locations using boolean Tag| headers.
Bulk creation and edition of location tags provided through CSV files in configuration/locationtags.
Bulk creation and edition of Bahmni forms provided as JSON schema definitions in configuration/bahmniforms.
Bulk creation and edition of htmlforms provided as XML schema definitions in configuration/htmlforms.
Version 2.0.0
Support for conditional loading of domains based on the runtime availability of OpenMRS modules.
Bulk creation and edition of programs provided through CSV files in configuration/programs.
Bulk creation and edition of program workflows provided through CSV files in configuration/programworkflows.
Bulk creation and edition of program workflow states provided through CSV files in configuration/programworkflowstates.
Bulk creation and edition of privileges provided through CSV files in configuration/privileges.
Bulk creation and edition of roles provided through CSV files in configuration/roles.
Bulk creation and edition of metadata terms mappings provided through CSV files in configuration/metadatatermmappings.
Bulk creation and edition of encounter types provided through CSV files in configuration/encountertypes.
Bulk creation and edition of Bahmni appointments specialities provided through CSV files in configuration/appointmentsspecialities.
Bulk access management of Data Filter entity to basis mappings provided through CSV files in configuration/datafiltermappings.
Bulk creation and edition of attribute types provided through CSV files in configuration/attributetypes.
Support location attributes.
Bulk creation and edition of patient identifier types provided through CSV files in configuration/patientidentifiertypes.
Bulk creation and edition of metadata terms mappings provided through CSV files in configuration/metadatasets.
Bulk creation and edition of metadata terms mappings provided through CSV files in configuration/metadatasetmembers.
Bulk creation and edition of bahmni forms provided JSON files in configuration/bahmniforms
Support concept attributes.
Version 1.1.0
Bulk creation and edition of drugs provided through CSV files in configuration/locations.
Version 1.0.1
Loads i18n messages files from configuration/addresshierarchy and configuration/messageproperties.
Bulk creation and edition of concepts provided through CSV files in configuration/concepts.
This covers: basic concepts, concepts with nested members or answers and concepts with multiple mappings.
Bulk creation and edition of drugs provided through CSV files in configuration/drugs.
Overrides global properties provided through XML configuration files in configuration/globalproperties.
Modifies (retire) or create ID Gen's identifier sources through CSV files in configuration/idgen.
Exposes runtime key-values configuration parameters through JSON files in configuration/jsonkeyvalues.
Bulk creation and edition of person attribute types provided through CSV files in configuration/personattributetypes.
Imports MDS packages provided as .zip files in configuration/metadatasharing.
Bulk creation and edition of order frequencies provided through CSV files in configuration/orderfrequencies.
