using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.AI;

public class NPCBrian : MonoBehaviour
{
    public GameObject girlFirstDestination;
    public GameObject girlSecondDestination;
    public GameObject girlThirdDestination;
    public GameObject girlFourthDestination;
    public GameObject girlFifthDestination;

    NavMeshAgent theAgent;
    Animator BrianAnim;

    // Start is called before the first frame update
    void Start()
    {
        theAgent = GetComponent<NavMeshAgent>();
        BrianAnim = GetComponent<Animator>();
        StartCoroutine(Brian());
    }

    IEnumerator Brian()
    {
        yield return new WaitForSeconds(3.0f);
        BrianAnim.SetBool("isWalking", true);
        theAgent.SetDestination(girlThirdDestination.transform.position);
        yield return new WaitForSeconds(2.7f);
        BrianAnim.SetBool("isWalking", false);
        yield return new WaitForSeconds(2.0f);

        BrianAnim.SetBool("isWalking", true);
        theAgent.SetDestination(girlSecondDestination.transform.position);
        yield return new WaitForSeconds(4.2f);
        BrianAnim.SetBool("isWalking", false);
        yield return new WaitForSeconds(2.0f);

        BrianAnim.SetBool("isWalking", true);
        theAgent.SetDestination(girlFourthDestination.transform.position);
        yield return new WaitForSeconds(4.5f);
        BrianAnim.SetBool("isWalking", false);
        yield return new WaitForSeconds(2.0f);

        BrianAnim.SetBool("isWalking", true);
        theAgent.SetDestination(girlFirstDestination.transform.position);
        yield return new WaitForSeconds(6f);
        gameObject.SetActive(false);
        yield return null;
    }
}
