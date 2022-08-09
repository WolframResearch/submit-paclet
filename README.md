# Submit Paclet to the [Wolfram Language Paclet Repository](https://resources.wolframcloud.com/PacletRepository/)

The Submit Paclet action is an interface to the 
[`SubmitPaclet`](https://resources.wolframcloud.com/PacletRepository/resources/Wolfram/PacletCICD/ref/SubmitPaclet.html) 
function from 
[Wolfram/PacletCICD](https://resources.wolframcloud.com/PacletRepository/resources/Wolfram/PacletCICD/) 
and can be used to publish your Wolfram Language paclet from within GitHub Actions. 
This is roughly equivalent to using the **Submit to Repository** button from the resource definition notebook within 
Wolfram Desktop or Mathematica.

## Usage

A YAML file that uses this action can be automatically generated for your paclet using 
[`WorkflowExport`](https://resources.wolframcloud.com/PacletRepository/resources/Wolfram/PacletCICD/ref/WorkflowExport.html):

```Mathematica
PacletSymbol["Wolfram/PacletCICD", "WorkflowExport"]["path/to/paclet", "Submit"]
```

Alternatively, using GitHub actions YAML syntax directly:
```yaml
name: Submit Paclet
on: [workflow_dispatch]
jobs: 
  Submit: 
    name: Submit Paclet
    runs-on: ubuntu-latest
    container: 
      image: wolframresearch/wolframengine:latest
      options: --user root
    env: 
      WOLFRAMSCRIPT_ENTITLEMENTID: ${{ secrets.WOLFRAMSCRIPT_ENTITLEMENTID }}
      RESOURCE_PUBLISHER_TOKEN: ${{ secrets.RESOURCE_PUBLISHER_TOKEN }}
    steps: 
    - name: Checkout repository
      uses: actions/checkout@v2
    - name: Submit paclet
      uses: WolframResearch/submit-paclet@v1
```

## Parameters

Input                     | Default                     | Description
------------------------- | --------------------------- | ---------------
`definition_notebook`     | `"./ResourceDefinition.nb"` | The relative path to the paclet's resource definition notebook
`paclet_cicd_version`     | `"latest"`                  | The version of [PacletCICD](https://resources.wolframcloud.com/PacletRepository/resources/Wolfram/PacletCICD/) to use

## Notes
For this action to work, your repository needs to have a license entitlement ID and a resource publisher token defined as repository secrets. See [this tutorial](https://resources.wolframcloud.com/PacletRepository/resources/Wolfram/PacletCICD/tutorial/GitHubActionsQuickStart.html) for details.


## See Also

- [Action for building your paclet](https://github.com/WolframResearch/build-paclet)
- [Action for checking your paclet for potential issues](https://github.com/WolframResearch/check-paclet)
- [Action for running your paclet test files](https://github.com/WolframResearch/test-paclet)
- [Continuous Integration and Deployment for Wolfram Language Paclets](https://resources.wolframcloud.com/PacletRepository/resources/Wolfram/PacletCICD/)