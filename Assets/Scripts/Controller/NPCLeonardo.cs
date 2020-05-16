using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.AI;

public class NPCLeonardo : MonoBehaviour
{
    public GameObject girlFirstDestination;
    public GameObject girlSecondDestination;
    public GameObject girlThirdDestination;
    public GameObject girlFourthDestination;
    public GameObject girlFifthDestination;
    public GameObject girlSixthDestination;
    public GameObject girlSeventhDestination;

    NavMeshAgent theAgent;
    Animator LeoAnim;

    // Start is called before the first frame update
    void Start()
    {
        theAgent = GetComponent<NavMeshAgent>();
        LeoAnim = GetComponent<Animator>();
        StartCoroutine(Leonardo());
    }

    IEnumerator Leonardo()
    {

        yield return new WaitForSeconds(10.0f);
        LeoAnim.SetBool("isWalking", true);
        theAgent.SetDestination(girlSixthDestination.transform.position);
        yield return new WaitForSeconds(12.2f);
        LeoAnim.SetBool("isWalking", false);
        yield return new WaitForSeconds(4.5f);

        LeoAnim.SetBool("isWalking", true);
        theAgent.SetDestination(girlFourthDestination.transform.position);
        yield return new WaitForSeconds(4.2f);
        LeoAnim.SetBool("isWalking", false);
        yield return new WaitForSeconds(3.0f);

        LeoAnim.SetBool("isWalking", true);
        theAgent.SetDestination(girlFirstDestination.transform.position);
        yield return new WaitForSeconds(10.0f);
        gameObject.SetActive(false);
        yield return null;
    }
}
