using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.SceneManagement;

public class BirdInCage : MonoBehaviour
{
    [SerializeField] GameObject panel;
    [SerializeField] GameObject ui;
    [SerializeField] VolumeProfile dp;
    [SerializeField] VolumeProfile np;
    [SerializeField] GameObject pic;
    [SerializeField] GameObject cage;
    [SerializeField] GameObject cage2;
    [SerializeField] GameObject cage3;
    [SerializeField] GameObject cage4;
    [SerializeField] GameObject rob;
    [SerializeField] GameObject rob2;
    [SerializeField] GameObject fadeOut;
    [SerializeField] GameObject pin;

    VolumeProfile pp;
    UnstableScanMode usm;

    DialogueManager theDM;
    public bool iscageInteracted = false;
    public bool ispictureInteracted = false;
    public static bool isStart = false;
    bool iscageEnd = false;
    bool ispicEnd = false;

    // Start is called before the first frame update
    void Start()
    {
        isStart = false;
        ispictureInteracted = false;
        theDM = FindObjectOfType<DialogueManager>();
        usm = FindObjectOfType<UnstableScanMode>();
        StartCoroutine(startMuseum());
        
    }

    // Update is called once per frame
    void Update()
    {
        
        
        usm.p2 = pp;
        
        

        if (GameObject.Find("Museum Volume").GetComponent<Volume>().profile == usm.p1) { }
        else
        {
            GameObject.Find("Museum Volume").GetComponent<Volume>().profile = pp;
        }

        

        if (!DialogueManager.isRealEnd && isStart)
        {
            iscageInteracted = CageInteract.cageisInteracted;
            if (iscageInteracted && !iscageEnd)
            {
                StartCoroutine(cageMuseum());
            }
            if(iscageEnd)
            {
                StartCoroutine(changeScene());
            }
        }
        else { }
    }

    IEnumerator startMuseum()
    {
        Debug.Log("start");
        yield return new WaitForSeconds(2.0f);
        DialogueManager.isMonologue = true;
        gameObject.GetComponent<InteractionEvent>().dialogue.line.x = 1;
        gameObject.GetComponent<InteractionEvent>().dialogue.line.y = 2;
        theDM.ShowDialogue(gameObject.GetComponent<InteractionEvent>().GetDialogue());
        yield return new WaitUntil(() => DialogueManager.isRealEnd);
        DialogueManager.isRealEnd = false;

        yield return new WaitForSeconds(2.0f);
        pp = dp;
        yield return new WaitForSeconds(1.0f);
        pp = np;
        yield return new WaitForSeconds(1.3f);
        pp = dp;
        yield return new WaitForSeconds(0.4f);
        pp = np;
        DialogueManager.isMonologue = true;
        gameObject.GetComponent<InteractionEvent>().dialogue.line.x = 3;
        gameObject.GetComponent<InteractionEvent>().dialogue.line.y = 3;
        theDM.ShowDialogue(gameObject.GetComponent<InteractionEvent>().GetDialogue());
        yield return new WaitUntil(() => DialogueManager.isRealEnd);
        DialogueManager.isRealEnd = false;
        yield return new WaitForSeconds(1.0f);
        ui.SetActive(true);
        panel.SetActive(true);

        yield return new WaitForSeconds(4.5f);
        ui.SetActive(false);
        panel.SetActive(false);
        isStart = true;
        gameObject.GetComponent<InteractionController>().enabled = true;
    }

    IEnumerator cageMuseum()
    {
        Debug.Log("cage");
        iscageEnd = true;
        DialogueManager.isMonologue = true;
        gameObject.GetComponent<InteractionEvent>().dialogue.line.x = 5;
        gameObject.GetComponent<InteractionEvent>().dialogue.line.y = 5;
        theDM.ShowDialogue(gameObject.GetComponent<InteractionEvent>().GetDialogue());
        yield return new WaitUntil(() => DialogueManager.isRealEnd);
        DialogueManager.isRealEnd = false;
        cage.GetComponent<SearchingObj>().highlightMat = cage.GetComponent<SearchingObj>().originalMat1;
        cage2.GetComponent<SearchingObj>().highlightMat = cage2.GetComponent<SearchingObj>().originalMat1;
        cage3.GetComponent<SearchingObj>().highlightMat = cage3.GetComponent<SearchingObj>().originalMat1;
        cage4.GetComponent<SearchingObj>().highlightMat = cage4.GetComponent<SearchingObj>().originalMat1;
        StopAllCoroutines();
    }
    IEnumerator changeScene()
    {
        yield return new WaitForSeconds(1.0f);
        fadeOut.SetActive(true);
        yield return new WaitForSeconds(3.0f);
        Destroy(pin);
        SceneManager.LoadScene("001_Museum");
    }

}
