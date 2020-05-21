using Invector.vCharacterController;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.AI;
using UnityEngine.Rendering;
using UnityEngine.SceneManagement;

public class GirlAI : MonoBehaviour
{
    [SerializeField] public int destNum = 0;
    [SerializeField] GameObject pin;
    public GameObject girlFirstDestination;
    public GameObject girlSecondDestination;
    public GameObject girlThirdDestination;
    public GameObject girlFourthDestination;
    public GameObject girlFifthDestination;
    public GameObject girlSearchDestination;
    public GameObject girlFinalDestination;
    public VolumeProfile dp;

    DialogueManager theDM;
    NavMeshAgent theAgent;
    Animator girlAnim;


    
    public static bool isFound = false;
    public static bool isPlaying = false;
    public static bool isPicking = false;
    public static bool isThanks = false;
    public static bool isSad = false;
    public static bool isIndicate = false;
    public static float waitTime = 0.8f;
    public static bool isFirst = false;
    public static bool isSecond = false;
    public static bool isThird = false;
    public static bool isFourth = false;
    public static bool isFifth = false;
    public static bool isSixth = false;
    public static bool isSeventh = false;
    public static bool isExit = false;

    public static bool isAntonio = false;


    // Start is called before the first frame update
    void Start()
    {
        isFound = false;
        isPlaying = false;
        isPicking = false;
        isThanks = false;
        isSad = false;
        isIndicate = false;
        isFirst = false;
        isSecond = false;
        isThird = false;
        isFourth = false;
        isFifth = false;
        isSixth = false;
        isSeventh = false;
        isExit = false;
        theDM = FindObjectOfType<DialogueManager>();
        //GameObject.Find("Manager").GetComponent<ScanMode>().enabled = false;
        theAgent = GetComponent<NavMeshAgent>();
        girlAnim = GetComponent<Animator>();
        GameObject.FindWithTag("Player").GetComponent<vThirdPersonController>().Strafe();
        StartCoroutine(GirlEntrance());
        
    }

    // Update is called once per frame
    void Update()
    {
        if (destNum == 1 && !isFirst)
        {
            
            StartCoroutine(goSecond());
        }
        else if(destNum == 2 && !isSecond)
        {
            
            StartCoroutine(goThird());
        }
        else if (destNum == 3 && !isThird)
        {
            
            StartCoroutine(goFourth());
        }
        else if (destNum == 4 && !isFourth)
        {
            
            StartCoroutine(startFind());
        }
        else if (destNum == 5 && !isFifth)
        {
            
            StartCoroutine(reFourth());
        }else if (destNum == 6 && !isSixth)
        {
            
            StartCoroutine(goFifth());
        }else if (destNum == 7 && !isSeventh)
        {

            StartCoroutine(rereFourth());
        }else if (destNum == 8 && !isPlaying)
        {
            
            StartCoroutine(reFifth());
        }
        else if (destNum == 9 && !isSad)
        {
            
            StartCoroutine(soSad());
        }else if (destNum == 10 && isIndicate)
        {
            
            StartCoroutine(indicateToy());
        }else if(destNum == 11 && !isPicking)
        {
            
            StartCoroutine(pickingToy());
        }
        else if(destNum == 12 && isPicking)
        {
            
            StartCoroutine(sayThanks());
        }else if (destNum == 13 && !isExit)
        {
            StartCoroutine(exit());
            
        }
    }

    void OnTriggerEnter(Collider other)
    {
        if (other.tag == "Destination")
        {
            destNum++;
            Debug.Log(destNum);
        }
    }

    IEnumerator GirlEntrance()
    {
        Debug.Log("Entrance" + destNum);
        girlAnim.SetBool("isRunning", true);
        theAgent.SetDestination(girlFirstDestination.transform.position);
        yield return new WaitForSeconds(3.0f);
        GameObject.FindWithTag("Toy").GetComponent<MeshRenderer>().enabled = true;
        yield return new WaitForSeconds(1.0f);
        //메쉬 렌더러 온
    }

    
    IEnumerator goSecond()
    {
        isFirst = true;
        Debug.Log("goSecond" + destNum);
        girlAnim.SetBool("isRunning", false);
        yield return new WaitForSeconds(waitTime);
        girlAnim.SetBool("isRunning", true);
        theAgent.SetDestination(girlSecondDestination.transform.position);
        yield return new WaitForSeconds(4.0f);
        DialogueManager.isMonologue = true;
        gameObject.GetComponent<InteractionEvent>().dialogue.line.x = 1;
        gameObject.GetComponent<InteractionEvent>().dialogue.line.y = 1;
        theDM.ShowDialogue(gameObject.GetComponent<InteractionEvent>().GetDialogue());
        yield return new WaitUntil(() => DialogueManager.isRealEnd);
        DialogueManager.isRealEnd = false;
        isPlaying = false;
    }

    IEnumerator goThird()
    {
        isSecond = true;
        Debug.Log("goThird" + destNum);
        girlAnim.SetBool("isRunning", false);
        yield return new WaitForSeconds(waitTime);
        girlAnim.SetBool("isRunning", true);
        theAgent.SetDestination(girlThirdDestination.transform.position);
        yield return new WaitForSeconds(5.0f);
        isPlaying = false;
    }

    IEnumerator goFourth()
    {
        isThird = true;
        Debug.Log("goFourth" + destNum);
        girlAnim.SetBool("isRunning", false);
        yield return new WaitForSeconds(waitTime);
        girlAnim.SetBool("isRunning", true);
        theAgent.SetDestination(girlFourthDestination.transform.position);
        yield return new WaitForSeconds(4.0f);
        isPlaying = false;
    }
    IEnumerator reFourth()
    {
        isFifth = true;
        Debug.Log("reFourth" + destNum);
        girlAnim.SetBool("isRunning", true);
        theAgent.SetDestination(girlFourthDestination.transform.position);
        isPlaying = false;
        yield return new WaitForSeconds(4.0f);
    }

    IEnumerator rereFourth()
    {
        isSeventh = true;
        Debug.Log("reFourth" + destNum);
        girlAnim.SetBool("isRunning", true);
        theAgent.SetDestination(girlFourthDestination.transform.position);
        isPlaying = false;
        yield return new WaitForSeconds(4.0f);
    }

    IEnumerator goFifth()
    {
        isSixth = true;
        Debug.Log("goFifth" + destNum);
        girlAnim.SetBool("isRunning", true);
        theAgent.SetDestination(girlFifthDestination.transform.position);
        isPlaying = false;
        yield return new WaitForSeconds(4.0f);
    }
    
        IEnumerator reFifth()
    {
        isPlaying = true;
        Debug.Log("goFifth" + destNum);
        girlAnim.SetBool("isRunning", true);
        theAgent.SetDestination(girlFifthDestination.transform.position);
        isPlaying = false;
        yield return new WaitForSeconds(4.0f);
    }
    IEnumerator startFind()
    {
        isFourth = true;
        Debug.Log("startFind" + destNum);
        girlAnim.SetBool("isRunning", false);
        yield return new WaitForSeconds(waitTime);
        girlAnim.SetBool("isSearching", true);
        yield return new WaitForSeconds(10.2f);
        girlAnim.SetBool("isRunning", true);
        theAgent.SetDestination(girlFifthDestination.transform.position);
        girlAnim.SetBool("isSearching", false);
        yield return new WaitForSeconds(2.0f);
        DialogueManager.isMonologue = true;
        gameObject.GetComponent<InteractionEvent>().dialogue.line.x = 2;
        gameObject.GetComponent<InteractionEvent>().dialogue.line.y = 2;
        theDM.ShowDialogue(gameObject.GetComponent<InteractionEvent>().GetDialogue());
        yield return new WaitUntil(() => DialogueManager.isRealEnd);
        DialogueManager.isRealEnd = false;
        yield return new WaitForSeconds(2.0f);
        
        isPlaying = false;
    }

    IEnumerator soSad()
    {
        isSad = true;
        girlAnim.SetBool("isRunning", false);
        DialogueManager.isRealEnd = false;
        Debug.Log("soSad" + destNum);
        girlAnim.SetBool("isCrying", true);
        yield return new WaitForSeconds(0.5f);
        DialogueManager.isMonologue = true;
        gameObject.GetComponent<InteractionEvent>().dialogue.line.x = 3;
        gameObject.GetComponent<InteractionEvent>().dialogue.line.y = 3;
        theDM.ShowDialogue(gameObject.GetComponent<InteractionEvent>().GetDialogue());
        yield return new WaitUntil(() => DialogueManager.isRealEnd);
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
        DialogueManager.isMonologue = true;
        gameObject.GetComponent<InteractionEvent>().dialogue.line.x = 9;
        gameObject.GetComponent<InteractionEvent>().dialogue.line.y = 9;
        theDM.ShowDialogue(gameObject.GetComponent<InteractionEvent>().GetDialogue());
        yield return new WaitUntil(() => DialogueManager.isRealEnd);
        DialogueManager.isRealEnd = false;
        isIndicate = true;
        destNum++;
    }

    IEnumerator indicateToy()
    {
        isIndicate = false;
        Debug.Log("indicate" + destNum);
        girlAnim.SetBool("isRunning", false);
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
        yield return new WaitUntil(() => DialogueManager.isRealEnd);
        DialogueManager.isRealEnd = false;
        girlAnim.SetBool("isCrying", false);
        girlAnim.SetBool("isRunning", true);
        theAgent.SetDestination(girlSearchDestination.transform.position);
    }

    IEnumerator pickingToy()
    {
        isPicking = true;
        Debug.Log("PickUp" + destNum);
        girlAnim.SetBool("isRunning", false);
        yield return new WaitForSeconds(2.1f);
        girlAnim.SetBool("isPickUp", true);
        yield return new WaitForSeconds(2.1f);

        //메쉬 렌더러 오프
        GameObject.FindWithTag("Toy").GetComponent<MeshRenderer>().enabled = false;

        girlAnim.SetBool("isPickUp", false);
        yield return new WaitForSeconds(1.5f);
        girlAnim.SetBool("isRunning", true);
        theAgent.SetDestination(girlFifthDestination.transform.position);
        isPlaying = false;
    }

    IEnumerator sayThanks()
    {
        isPicking = false;
        Debug.Log("sayThanks" + destNum);
        girlAnim.SetBool("isRunning", false);
        DialogueManager.isRealEnd = false;
        gameObject.GetComponent<InteractionEvent>().isFirst = true;
        gameObject.GetComponent<InteractionEvent>().dialogue.line.x = 12;
        gameObject.GetComponent<InteractionEvent>().dialogue.line.y = 32;
        gameObject.tag = "Interaction";
        yield return new WaitUntil(() => DialogueManager.isRealEnd);
        DialogueManager.isRealEnd = false;
        gameObject.tag = "Girl";
        destNum++;
    }

    IEnumerator exit()
    {
        isExit = true;
        Debug.Log("isExit" + destNum);
        girlAnim.SetBool("isRunning", false);
        girlAnim.SetBool("isExit", true);
        yield return new WaitForSeconds(3.2f);
        girlAnim.SetBool("isRunning", true);
        theAgent.SetDestination(girlFinalDestination.transform.position);
        yield return new WaitForSeconds(10.0f);
        DialogueManager.isMonologue = true;
        gameObject.GetComponent<InteractionEvent>().dialogue.line.x = 33;
        gameObject.GetComponent<InteractionEvent>().dialogue.line.y = 33;
        theDM.ShowDialogue(gameObject.GetComponent<InteractionEvent>().GetDialogue());
        yield return new WaitUntil(() => DialogueManager.isRealEnd);
        DialogueManager.isRealEnd = false;
        GameObject.Find("Museum Volume").GetComponent<Volume>().profile = dp;

        yield return new WaitForSeconds(2.0f);
        Destroy(pin);
        SceneManager.LoadScene("002_Dark_Museum");
        
        
    }
}
