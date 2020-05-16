using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.AI;

public class NPCJackie : MonoBehaviour
{
    public GameObject girlFirstDestination;
    public GameObject girlSecondDestination;
    public GameObject girlThirdDestination;
    public GameObject girlFourthDestination;
    public GameObject girlFifthDestination;
    public GameObject girlSixthDestination;
    public GameObject girlSeventhDestination;

    NavMeshAgent theAgent;
    Animator JackAnim;

    // Start is called before the first frame update
    void Start()
    {
        theAgent = GetComponent<NavMeshAgent>();
        JackAnim = GetComponent<Animator>();
        StartCoroutine(Jackie());
    }

    IEnumerator Jackie()
    {
        yield return new WaitForSeconds(2.1f);
        JackAnim.SetBool("isWalking", true);
        theAgent.SetDestination(girlSecondDestination.transform.position);
        yield return new WaitForSeconds(2.3f);
        JackAnim.SetBool("isWalking", false);
        yield return new WaitForSeconds(2.0f);

        JackAnim.SetBool("isWalking", true);
        theAgent.SetDestination(girlSeventhDestination.transform.position);
        yield return new WaitForSeconds(5.8f);
        JackAnim.SetBool("isWalking", false);
        yield return new WaitForSeconds(1.0f);

        JackAnim.SetBool("isWalking", true);
        theAgent.SetDestination(girlSixthDestination.transform.position);
        yield return new WaitForSeconds(5.2f);
        JackAnim.SetBool("isWalking", false);
        yield return new WaitForSeconds(2.4f);

        JackAnim.SetBool("isWalking", true);
        theAgent.SetDestination(girlFourthDestination.transform.position);
        yield return new WaitForSeconds(3.5f);
        JackAnim.SetBool("isWalking", false);
        yield return new WaitForSeconds(7.0f);

        JackAnim.SetBool("isWalking", true);
        theAgent.SetDestination(girlFirstDestination.transform.position);
        yield return new WaitForSeconds(10f);
        gameObject.SetActive(false);
        yield return null;
    }
}
