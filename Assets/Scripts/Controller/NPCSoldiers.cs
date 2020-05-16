using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.AI;

public class NPCSoldiers : MonoBehaviour
{
    public GameObject girlFirstDestination;
    public GameObject girlSecondDestination;
    public GameObject girlThirdDestination;
    public GameObject girlFourthDestination;
    public GameObject girlFifthDestination;
    public GameObject girlSixthDestination;

    NavMeshAgent theAgent;
    public static int destNum = 0;
    // Start is called before the first frame update
    void Start()
    {
        theAgent = GetComponent<NavMeshAgent>();
        theAgent.SetDestination(girlSixthDestination.transform.position);
    }
    private void Update()
    {  

    }
}
