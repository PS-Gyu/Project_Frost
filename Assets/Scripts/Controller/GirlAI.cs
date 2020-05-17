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
    public static bool isPicking = false;
    public static bool isThanks = false;
    public static bool isSad = false;
    public static bool isIndicate = false;
    public static float waitTime = 0.8f;

    public static bool isAntonio = false;

    // Start is called before the first frame update
    void Start()
    {
        theDM = FindObjectOfType<DialogueManager>();
        //GameObject.Find("Manager").GetComponent<ScanMode>().enabled = false;
        theAgent = GetComponent<NavMeshAgent>();
        girlAnim = GetComponent<Animator>();
        GameObject.FindWithTag("Player").GetComponent<vThirdPersonController>().Strafe();
        isPlaying = true;
        StartCoroutine(GirlEntrance());
    }

    // Update is called once per frame
    void Update()
    {
        if (destNum == 1 && !isPlaying)
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
        else if (destNum == 9 && !isSad)
        {
            isSad = true;
            StartCoroutine(soSad());
        }else if (destNum == 9 && isIndicate)
        {
            isIndicate = false;
            StartCoroutine(indicateToy());
        }else if(destNum == 10 && !isPicking)
        {
            isPicking = true;
            StartCoroutine(pickingToy());
        }
        else if(destNum == 11 && isPicking)
        {
            isPicking = false;
            StartCoroutine(sayThanks());
        }else if (destNum == 11 && exitTime)
        {
            //StartCoroutine(exit());
            
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
        girlAnim.SetBool("isRunning", true);
        theAgent.SetDestination(girlFirstDestination.transform.position);
        yield return new WaitForSeconds(4.0f);
        GameObject.FindWithTag("Toy").GetComponentInChildren<MeshRenderer>().enabled = true;
        yield return new WaitForSeconds(3.0f);
        isPlaying = false;
    }

    
    IEnumerator goSecond()
    {
        Debug.Log("goSecond" + destNum);
        girlFirstDestination.SetActive(false);
        yield return new WaitForSeconds(waitTime);
        girlAnim.SetBool("isRunning", true);
        theAgent.SetDestination(girlSecondDestination.transform.position);
        yield return new WaitForSeconds(4.0f);
        DialogueManager.isMonologue = true;
        gameObject.GetComponent<InteractionEvent>().dialogue.line.x = 1;
        gameObject.GetComponent<InteractionEvent>().dialogue.line.y = 1;
        theDM.ShowDialogue(gameObject.GetComponent<InteractionEvent>().GetDialogue());
        DialogueManager.isRealEnd = false;
        isPlaying = false;
    }

    IEnumerator goThird()
    {
        Debug.Log("goThird" + destNum);
        girlSecondDestination.SetActive(false);
        yield return new WaitForSeconds(waitTime);
        girlAnim.SetBool("isRunning", true);
        theAgent.SetDestination(girlThirdDestination.transform.position);
        yield return new WaitForSeconds(5.0f);
        isPlaying = false;
    }

    IEnumerator goFourth()
    {
        Debug.Log("goFourth" + destNum);
        girlThirdDestination.SetActive(false);
        yield return new WaitForSeconds(waitTime);
        girlAnim.SetBool("isRunning", true);
        theAgent.SetDestination(girlFourthDestination.transform.position);
        yield return new WaitForSeconds(4.0f);
        isPlaying = false;
    }
    IEnumerator reFourth()
    {
        Debug.Log("reFourth" + destNum);
        girlAnim.SetBool("isRunning", true);
        theAgent.SetDestination(girlFourthDestination.transform.position);
        isPlaying = false;
        yield return new WaitForSeconds(4.0f);

    }

    IEnumerator goFifth()
    {
        Debug.Log("goFifth" + destNum);
        girlAnim.SetBool("isRunning", true);
        theAgent.SetDestination(girlFifthDestination.transform.position);
        isPlaying = false;
        yield return new WaitForSeconds(4.0f);

    }

    IEnumerator startFind()
    {
        Debug.Log("startFind" + destNum);
        yield return new WaitForSeconds(waitTime);
        girlAnim.SetBool("isSearching", true);
        yield return new WaitForSeconds(6.2f);
        girlAnim.SetBool("isRunning", true);
        theAgent.SetDestination(girlFifthDestination.transform.position);
        girlAnim.SetBool("isSearching", false);
        yield return new WaitForSeconds(2.0f);
        DialogueManager.isMonologue = true;
        gameObject.GetComponent<InteractionEvent>().dialogue.line.x = 2;
        gameObject.GetComponent<InteractionEvent>().dialogue.line.y = 2;
        theDM.ShowDialogue(gameObject.GetComponent<InteractionEvent>().GetDialogue());
        DialogueManager.isRealEnd = false;
        yield return new WaitForSeconds(2.0f);
        
        isPlaying = false;
    }

    IEnumerator soSad()
    {
        DialogueManager.isRealEnd = false;
        Debug.Log("soSad" + destNum);
        girlAnim.SetBool("isCrying", true);
        yield return new WaitForSeconds(0.5f);
        DialogueManager.isMonologue = true;
        gameObject.GetComponent<InteractionEvent>().dialogue.line.x = 3;
        gameObject.GetComponent<InteractionEvent>().dialogue.line.y = 3;
        theDM.ShowDialogue(gameObject.GetComponent<InteractionEvent>().GetDialogue());
        DialogueManager.isRealEnd = false;
        gameObject.tag = "Interaction";
        gameObject.GetComponent<InteractionEvent>().dialogue.line.x = 4;
        gameObject.GetComponent<InteractionEvent>().dialogue.line.y = 8;
        yield return new WaitUntil(() => DialogueManager.isRealEnd);
        DialogueManager.isRealEnd = false;
        gameObject.tag = "Girl";
        GameObject.Find("Manager").GetComponent<UnstableScanMode>().enabled = true;
        GameObject.FindWithTag("Player").GetComponent<vThirdPersonController>().Strafe();
        yield return new WaitUntil(() => isFound && GameObject.Find("Manager").GetComponent<UnstableScanMode>().enabled);
        DialogueManager.isRealEnd = false;
        DialogueManager.isMonologue = true;
        gameObject.GetComponent<InteractionEvent>().dialogue.line.x = 9;
        gameObject.GetComponent<InteractionEvent>().dialogue.line.y = 9;
        theDM.ShowDialogue(gameObject.GetComponent<InteractionEvent>().GetDialogue());
        DialogueManager.isRealEnd = false;
        yield return new WaitForSeconds(6.0f);
        isIndicate = true;
        
    }

    IEnumerator indicateToy()
    {
        Debug.Log("indicate" + destNum);
        DialogueManager.isRealEnd = false;
        gameObject.GetComponent<InteractionEvent>().isFirst = true;
        gameObject.GetComponent<InteractionEvent>().dialogue.line.x = 10;
        gameObject.GetComponent<InteractionEvent>().dialogue.line.y = 10;
        gameObject.tag = "Interaction";
        yield return new WaitUntil(() => DialogueManager.isRealEnd);
        DialogueManager.isRealEnd = false;
        gameObject.tag = "Girl";
        yield return new WaitForSeconds(0.8f);
        DialogueManager.isMonologue = true;
        gameObject.GetComponent<InteractionEvent>().dialogue.line.x = 11;
        gameObject.GetComponent<InteractionEvent>().dialogue.line.y = 11;
        theDM.ShowDialogue(gameObject.GetComponent<InteractionEvent>().GetDialogue());
        DialogueManager.isRealEnd = false;
        girlAnim.SetBool("isCrying", false);
        girlAnim.SetBool("isRunning", true);
        theAgent.SetDestination(girlSearchDestination.transform.position);
    }

    IEnumerator pickingToy()
    {
        Debug.Log("PickUp" + destNum);
        yield return new WaitForSeconds(2.1f);
        girlAnim.SetBool("isPickUp", true);
        yield return new WaitForSeconds(2.1f);
        GameObject.FindWithTag("Toy").GetComponentInChildren<MeshRenderer>().enabled = false;
        girlAnim.SetBool("isPickUp", false);
        yield return new WaitForSeconds(1.5f);
        girlAnim.SetBool("isRunning", true);
        theAgent.SetDestination(girlFifthDestination.transform.position);
        isPlaying = false;
    }

    IEnumerator sayThanks()
    {
        DialogueManager.isRealEnd = false;
        Debug.Log("sayThanks" + destNum);
        gameObject.GetComponent<InteractionEvent>().isFirst = true;
        gameObject.GetComponent<InteractionEvent>().dialogue.line.x = 12;
        gameObject.GetComponent<InteractionEvent>().dialogue.line.y = 32;
        gameObject.tag = "Interaction";
        yield return new WaitUntil(() => DialogueManager.isRealEnd);
        DialogueManager.isRealEnd = false;
        gameObject.tag = "Girl";
        yield return StartCoroutine(exit());
    }

    IEnumerator exit()
    {
        Debug.Log("isExit" + destNum);
        girlAnim.SetBool("isExit", true);
        yield return new WaitForSeconds(3.2f);
        girlAnim.SetBool("isRunning", true);
        theAgent.SetDestination(girlFinalDestination.transform.position);
        yield return new WaitForSeconds(7.0f);
        isPlaying = false;
        DialogueManager.isMonologue = true;
        gameObject.GetComponent<InteractionEvent>().dialogue.line.x = 33;
        gameObject.GetComponent<InteractionEvent>().dialogue.line.y = 33;
        theDM.ShowDialogue(gameObject.GetComponent<InteractionEvent>().GetDialogue());
        DialogueManager.isRealEnd = false;
        yield return new WaitForSeconds(5.0f);

        isAntonio = true;
        gameObject.SetActive(false);
    }
}
