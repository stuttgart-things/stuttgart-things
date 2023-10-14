#!/bin/bash
failed_prs=0
succeeded_prs=0

all_prs=$(tkn pr list -n tektoncd | grep -c alpine)
echo all pipelineRuns: ${all_prs}

while [[ ${failed_prs} -ge 0  ]] || [[ ${succeeded_prs} -eq ${all_prs} ]]
do
    failed_prs=$(tkn pr list -n tektoncd | grep alpine | grep -c Failed)
    echo Failed pipelineRuns: ${failed_prs}
    tkn pr list -n tektoncd | grep alpine | grep Failed

    succeeded_prs=$(tkn pr list -n tektoncd | grep alpine | grep -c Succeeded)
    echo Succeeded pipelineRuns: ${succeeded_prs}
    tkn pr list -n tektoncd | grep alpine | grep Succeeded

    sleep 5
done

echo "Done watching pipelineRuns!"
echo Failed pipelineRuns: ${failed_prs}
echo Succeeded pipelineRuns: ${succeeded_prs}
