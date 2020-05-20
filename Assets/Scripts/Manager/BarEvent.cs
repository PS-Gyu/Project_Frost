using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BarEvent : MonoBehaviour
{
    DialogueManager theDM;
    [SerializeField] GameObject exitCollider;
    // Start is called before the first frame update
    void Start()
    {
        theDM = FindObjectOfType<DialogueManager>();
        StartCoroutine(streetSoldier());
    }

    // Update is called once per frame
    void Update()
    {
        
    }
    IEnumerator streetSoldier()
    {
        yield return new WaitForSeconds(2.0f);
        DialogueManager.isMonologue = true;
        gameObject.GetComponent<InteractionEvent>().dialogue.line.x = 1;
        gameObject.GetComponent<InteractionEvent>().dialogue.line.y = 10;
        theDM.ShowDialogue(gameObject.GetComponent<InteractionEvent>().GetDialogue());
        yield return new WaitUntil(() => DialogueManager.isRealEnd);
        DialogueManager.isRealEnd = false;

        //소녀 비명 사운드 삽입
        yield return new WaitForSeconds(4.0f);
        DialogueManager.isMonologue = true;
        gameObject.GetComponent<InteractionEvent>().dialogue.line.x = 11;
        gameObject.GetComponent<InteractionEvent>().dialogue.line.y = 15;
        theDM.ShowDialogue(gameObject.GetComponent<InteractionEvent>().GetDialogue());
        yield return new WaitUntil(() => DialogueManager.isRealEnd);
        DialogueManager.isRealEnd = false;

        exitCollider.SetActive(false);


        yield return null;
    }

}
