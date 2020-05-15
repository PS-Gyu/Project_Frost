using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.AI;

public class GirlAI : MonoBehaviour
{
    public GameObject girlFirstDestination;
    public GameObject girlFinalDestination;
    public GameObject girlInteractDestination;
    public GameObject girlSearchDestination;

    NavMeshAgent theAgent;
    Animator girlAnim;
    public static bool needInteract = false;
    public static bool isFound = false;
    public static bool isFinding = false;
    public static int destNum = 0;

    // Start is called before the first frame update
    void Start()
    {
        theAgent = GetComponent<NavMeshAgent>();
        girlAnim = GetComponent<Animator>();
    }

    // Update is called once per frame
    void Update()
    {
        if (destNum == 0)
        {
            girlAnim.SetBool("isWalking", true);
            theAgent.SetDestination(girlFirstDestination.transform.position);
        }
        else if(destNum == 1)
        {
            
            StartCoroutine(SecondDest());
            
            

        }
        else if(destNum == 2)
        {
            gameObject.tag = "Interaction";
            StartCoroutine(FirstInteract());
        }
    }

    private void OnTriggerEnter(Collider other)
    {
        if (other.tag == "Destination")
        {
            destNum++;
        }
    }


    IEnumerator SecondDest()
    {
        yield return new WaitForSeconds(4f);
        girlAnim.SetBool("isWalking", false);
        theAgent.SetDestination(girlInteractDestination.transform.position);
        girlAnim.SetBool("isWalking", true);
    }
    IEnumerator FirstInteract()
    {
        needInteract = true;
        
        girlAnim.SetBool("isSearching", true);
        yield return null;

        //InteractDestination 도착하면 Idle 후 조금 있다가 Search
        //좀 찾다가 우는 것까지
        //우는 도중 머리 위에 느낌표
        //느낌표 뜨게한 후 태그 변경(Interaction)
        //핀이 상호작용하면 대화
        //대화 끝나면 다시 태그 없앰
    }
    IEnumerator SecondInteract()
    {
        //핀이 첫 대화가 끝난 후 탭을 눌러 장난감을 찾으면 대화가능
        yield return null;
    }

    IEnumerator Finding()
    {
        //대화가 끝나면 소녀 SearchDestination까지 running
        //도착하면 Picking
        //Picking 끝나면 다시 InteractDestination까지 running
        //도착하면 대화
        //대화 끝나면 감사인사 후 퇴장(FinalDestination)
        //도착하면 setactive false
        yield return null;
    }
}
