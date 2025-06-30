import os
import uuid

# Directory containing the Swift source files for the Leads app
PROJECT_DIR = os.path.join('apps', 'CoreForgeLeads', 'DataForgeAIFull', 'Sources', 'DataForgeAI')


def new_id():
    return uuid.uuid4().hex.upper()[:24]


def generate_pbxproj():
    swift_files = [f for f in os.listdir(PROJECT_DIR) if f.endswith('.swift')]
    file_refs = []
    build_files = []
    file_ref_ids = []
    build_file_ids = []
    for f in sorted(swift_files):
        ref_id = new_id()
        file_refs.append(
            f"        {ref_id} /* {f} */ = {{isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = {f}; sourceTree = \"<group>\"; }};"
        )
        build_id = new_id()
        build_files.append(
            f"        {build_id} /* {f} in Sources */ = {{isa = PBXBuildFile; fileRef = {ref_id} /* {f} */; }};"
        )
        file_ref_ids.append(f"{ref_id} /* {f} */")
        build_file_ids.append(f"{build_id} /* {f} in Sources */")

    main_group = new_id()
    sources_phase = new_id()
    frameworks_phase = new_id()
    target = new_id()
    product = new_id()
    project = new_id()
    project_conf = new_id()
    debug_conf = new_id()
    release_conf = new_id()
    target_conf_list = new_id()

    pbxproj = f"""// !$*UTF8*$!
{{
    archiveVersion = 1;
    objectVersion = 56;
    classes = {{}};
    objects = {{

/* Begin PBXBuildFile section */
{chr(10).join(build_files)}
/* End PBXBuildFile section */

/* Begin PBXFileReference section */
{chr(10).join(file_refs)}
        {product} /* CoreForgeLeads.app */ = {{isa = PBXFileReference; explicitFileType = wrapper.application; path = CoreForgeLeads.app; sourceTree = BUILT_PRODUCTS_DIR; }};
/* End PBXFileReference section */

/* Begin PBXGroup section */
        {main_group} = {{
            isa = PBXGroup;
            children = (
                {chr(10).join('                ' + fr for fr in file_ref_ids)},
                {product} /* CoreForgeLeads.app */,
            );
            sourceTree = "<group>";
        }};
/* End PBXGroup section */

/* Begin PBXSourcesBuildPhase section */
        {sources_phase} = {{
            isa = PBXSourcesBuildPhase;
            buildActionMask = 2147483647;
            files = (
                {chr(10).join('                ' + bf for bf in build_file_ids)},
            );
            runOnlyForDeploymentPostprocessing = 0;
        }};
/* End PBXSourcesBuildPhase section */

/* Begin PBXFrameworksBuildPhase section */
        {frameworks_phase} = {{
            isa = PBXFrameworksBuildPhase;
            buildActionMask = 2147483647;
            files = (
            );
            runOnlyForDeploymentPostprocessing = 0;
        }};
/* End PBXFrameworksBuildPhase section */

/* Begin PBXNativeTarget section */
        {target} /* CoreForgeLeads */ = {{
            isa = PBXNativeTarget;
            buildConfigurationList = {target_conf_list} /* Build configuration list for PBXNativeTarget \"CoreForgeLeads\" */;
            buildPhases = (
                {sources_phase},
                {frameworks_phase},
            );
            buildRules = (
            );
            dependencies = (
            );
            name = CoreForgeLeads;
            productName = CoreForgeLeads;
            productReference = {product} /* CoreForgeLeads.app */;
            productType = "com.apple.product-type.application";
        }};
/* End PBXNativeTarget section */

/* Begin PBXProject section */
        {project} /* Project object */ = {{
            isa = PBXProject;
            attributes = {{
                LastUpgradeCheck = 1600;
                ORGANIZATIONNAME = "";
            }};
            buildConfigurationList = {project_conf} /* Build configuration list for PBXProject */;
            compatibilityVersion = "Xcode 16.0";
            developmentRegion = en;
            hasScannedForEncodings = 0;
            mainGroup = {main_group};
            projectDirPath = "";
            projectRoot = "";
            targets = (
                {target},
            );
        }};
/* End PBXProject section */

/* Begin XCBuildConfiguration section */
        {debug_conf} /* Debug */ = {{
            isa = XCBuildConfiguration;
            buildSettings = {{ }};
            name = Debug;
        }};
        {release_conf} /* Release */ = {{
            isa = XCBuildConfiguration;
            buildSettings = {{ }};
            name = Release;
        }};
/* End XCBuildConfiguration section */

/* Begin XCConfigurationList section */
        {target_conf_list} /* Build configuration list for PBXNativeTarget \"CoreForgeLeads\" */ = {{
            isa = XCConfigurationList;
            buildConfigurations = (
                {debug_conf} /* Debug */,
                {release_conf} /* Release */,
            );
            defaultConfigurationIsVisible = 0;
            defaultConfigurationName = Release;
        }};
        {project_conf} /* Build configuration list for PBXProject */ = {{
            isa = XCConfigurationList;
            buildConfigurations = (
                {debug_conf} /* Debug */,
                {release_conf} /* Release */,
            );
            defaultConfigurationIsVisible = 0;
            defaultConfigurationName = Release;
        }};
/* End XCConfigurationList section */

    }};
    rootObject = {project} /* Project object */;
}}"""
    return pbxproj

if __name__ == "__main__":
    pbxproj_content = generate_pbxproj()
    out_path = os.path.join('apps', 'CoreForgeLeads', 'CoreForgeLeads.xcodeproj', 'project.pbxproj')
    os.makedirs(os.path.dirname(out_path), exist_ok=True)
    with open(out_path, 'w') as f:
        f.write(pbxproj_content)
    print(f"Generated {out_path}")
