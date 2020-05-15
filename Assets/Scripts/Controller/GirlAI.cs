using Invector.vCharacterController;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.AI;

public class GirlAI : MonoBehaviour
{
    [SerializeField] public int destNum = 0;
    public GameObject girlFirstDestination;
    public GameObject girlSecondDestination;
    public GameObject girlThirdDestination;
    public GameObject girlFourthDestination;
    public GameObject girlFifthDestination;
    public GameObject girlSearchDestination;
    public GameObject girlFinalDestination;
    

    DialogueManager theDM;
    NavMeshAgent theAgent;
    Animator girlAnim;

    
    public static bool isFound = false;
    public static bool exitTime = false;
    public static bool isPlaying = false;
    public static float waitTime = 1.0f;

    // Start is called before the first frame update
    void Start()
    {
        theDM = FindObjectOfType<DialogueManager>();
        GameObject.Find("Manager").GetComponent<ScanMode>().enabled = false;
        theAgent = GetComponent<NavMeshAgent>();
        girlAnim = GetComponent<Animator>();
        GameObject.FindWithTag("Player").GetComponent<vThirdPersonController>().Strafe();

        
    }

    // Update is called once per frame
    void Update()
    {
        if(destNum == 0 && !isPlaying)
        {
            isPlaying = true;
            StartCoroutine(GirlEntrance());

        }
        else if (destNum == 1 && !isPlaying)
        {
            isPlaying = true;
            StartCoroutine(goSecond());
        }
        else if(destNum == 2 && !isPlaying)
        {
            isPlaying = true;
            StartCoroutine(goThird());
        }
        else if (destNum == 3 && !isPlaying)
        {
            isPlaying = true;
            StartCoroutine(goFourth());
        }
        else if (destNum == 4 && !isPlaying)
        {
            isPlaying = true;
            StartCoroutine(startFind());
        }
        else if (destNum == 5 && !isPlaying)
        {
            isPlaying = true;
            StartCoroutine(reFourth());
        }else if (destNum == 6 && !isPlaying)
        {
            isPlaying = true;
            StartCoroutine(goFifth());
        }else if (destNum == 7 && !isPlaying)
        {
            isPlaying = true;
            StartCoroutine(reFourth());
        }else if (destNum == 8 && !isPlaying)
        {
            isPlaying = true;
            girlFourthDestination.SetActive(false);
            StartCoroutine(goFifth());
        }
        else if (destNum == 9 && !isFound && !isPlaying)
        {
            isPlaying = true;
            StartCoroutine(soSad());
        }else if (destNum == 9 && isFound && !isPlaying)
        {
            isPlaying = true;
            StartCoroutine(indicateToy());
        }else if(destNum == 10 && !exitTime && !isPlaying)
        {
            isPlaying = true;
            StartCoroutine(sayThanks());
        }else if (destNum == 10 && exitTime && !isPlaying)
        {
            isPlaying = true;
            StartCoroutine(exit());
        }
    }

    void OnTriggerEnter(Collider other)
    {
        if (other.tag == "Destination")
        {
            destNum++;
            girlAnim.SetBool("isRunning", false);
        }
    }

    IEnumerator GirlEntrance()
    {
        Debug.Log("Entrance");
        girlAnim.SetBool("isRunning", true);
        theAgent.SetDestination(girlFirstDestination.transform.position);
        yield return new WaitForSeconds(2.0f);
        GameObject.FindWithTag("Toy").GetComponent<MeshRenderer>().enabled = true;
        yield return new WaitForSeconds(3.0f);
        isPlaying = false;
    }

    
    IEnumerator goSecond()
    {
        Debug.Log("goSecond");
        girlFirstDestination.SetActive(false);
        yield return new WaitForSeconds(waitTime);
        girlAnim.SetBool("isRunning", true);
        theAgent.SetDestination(girlSecondDestination.transform.position);
        yield return new WaitForSeconds(5.0f);
        isPlaying = false;
    }

    IEnumerator goThird()
    {
        Debug.Log("goThird");
        girlSecondDestination.SetActive(false);
        yield return new WaitForSeconds(waitTime);
        girlAnim.SetBool("isRunning", true);
        theAgent.SetDestination(girlThirdDestination.transform.position);
        yield return new WaitForSeconds(5.0f);
        isPlaying = false;
    }

    IEnumerator goFourth()
    {
        Debug.Log("goFourth");
        girlThirdDestination.SetActive(false);
        yield return new WaitForSeconds(waitTime);
        girlAnim.SetBool("isRunning", true);
        theAgent.SetDestination(girlFourthDestination.transform.position);
        yield return new WaitForSeconds(4.0f);
        isPlaying = false;
    }
    IEnumerator reFourth()
    {
        Debug.Log("reFourth");
        girlAnim.SetBool("isRunning", true);
        theAgent.SetDestination(girlFourthDestination.transform.position);
        yield return new WaitForSeconds(4.0f);
        isPlaying = false;
    }

    IEnumerator goFifth()
    {
        Debug.Log("goFifth");
        girlAnim.SetBool("isRunning", true);
        theAgent.SetDestination(girlFifthDestination.transform.position);
        yield return new WaitForSeconds(4.0f);
        isPlaying = false;
    }

    IEnumerator startFind()
    {
        Debug.Log("startFind");
        yield return new WaitForSeconds(waitTime);
        girlAnim.SetBool("isSearching", true);
        yield return new WaitForSeconds(4.5f);
        girlAnim.SetBool("isSearching", false);
        theAgent.SetDestination(girlFifthDestination.transform.position);
        yield return new WaitForSeconds(4.0f);
        isPlaying = false;
    }

    IEnumerator soSad()
    {
        Debug.Log("soSad");
        girlAnim.SetBool("isCrying", true);
        yield return new WaitForSeconds(2.5f);
        gameObject.GetComponent<InteractionEvent>().dialogue.line.x = 1;
        gameObject.GetComponent<InteractionEvent>().dialogue.line.y = 3;
        gameObject.tag = "Interaction";
        yield return new WaitUntil(() => DialogueManager.isRealEnd);
        DialogueManager.isRealEnd = false;
        GameObject.Find("Manager").GetComponent<ScanMode>().enabled = true;
        gameObject.tag = "Girl";
        GameObject.FindWithTag("Player").GetComponent<vThirdPersonController>().Strafe();
        yield return new WaitForSeconds(4.0f);
        isPlaying = false;
    }

    IEnumerator indicateToy()
    {
        Debug.Log("indicate");
        gameObject.GetComponent<InteractionEvent>().isFirst = true;
        gameObject.GetComponent<InteractionEvent>().dialogue.line.x = 4;
        gameObject.GetComponent<InteractionEvent>().dialogue.line.y = 5;
        gameObject.tag = "Interaction";
        yield return new WaitUntil(() => DialogueManager.isRealEnd);
        DialogueManager.isRealEnd = false;
        gameObject.tag = "Girl";

        girlAnim.SetBool("isRunning", true);
        theAgent.SetDestination(girlSearchDestination.transform.position);
        yield return new WaitForSeconds(4.0f);
        isPlaying = false;
    }

    IEnumerator pickingToy()
    {
        Debug.Log("PickUp");
        girlAnim.SetBool("isPickUp", true);
        yield return new WaitForSeconds(1.5f);
        GameObject.FindWithTag("Toy").GetComponent<MeshRenderer>().enabled = false;
        yield return new WaitForSeconds(1.5f);
        girlAnim.SetBool("isPickUp", false);
        theAgent.SetDestination(girlFifthDestination.transform.position);
        yield return new WaitForSeconds(4.0f);
        isPlaying = false;
    }

    IEnumerator sayThanks()
    {
        Debug.Log("sayThanks");
        gameObject.GetComponent<InteractionEvent>().isFirst = true;
        gameObject.GetComponent<InteractionEvent>().dialogue.line.x = 6;
        gameObject.GetComponent<InteractionEvent>().dialogue.line.y = 7;
        gameObject.tag = "Interaction";
        yield return new WaitUntil(() => DialogueManager.isRealEnd);
        DialogueManager.isRealEnd = false;
        gameObject.tag = "Girl";
        exitTime = true;
        yield return new WaitForSeconds(4.0f);
        isPlaying = false;
    }

    IEnumerator exit()
    {
        Debug.Log("isExit");
        girlAnim.SetBool("isExit", true);
        yield return new WaitForSeconds(4.2f);
        girlAnim.SetBool("isRunning", true);
        theAgent.SetDestination(girlFinalDestination.transform.position);
        yield return new WaitForSeconds(7.0f);
        isPlaying = false;
    }
}
