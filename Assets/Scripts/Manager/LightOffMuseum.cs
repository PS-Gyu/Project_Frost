using Invector.vCamera;
using System.Collections;
using System.Collections.Generic;
using UnityEditorInternal;
using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.SceneManagement;

public class LightOffMuseum : MonoBehaviour
{
    [SerializeField] GameObject goUI;
    DialogueManager theDM;
    float p_x = 0f;
    float p_y = 0f;
    float p_z = 0f;
    bool isRespawned = false;
    bool isSaved = false;
    Vector3 pos;
    // Start is called before the first frame update
    void Start()
    {
        isSaved = false;
        DarkMusFirst.firstDial = false;
        DarkMusSec.secDial = false;
        DarkMusThird.thirdDial = false;
        theDM = FindObjectOfType<DialogueManager>();
        StartCoroutine(lightOffMuseum());
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    public void loadSaved()
    {
        goUI.SetActive(false);
        if (isSaved)
        {
            StopAllCoroutines();

            p_x = GameObject.FindWithTag("Respawn").GetComponent<Transform>().position.x;
            p_y = GameObject.FindWithTag("Respawn").GetComponent<Transform>().position.y;
            p_z = GameObject.FindWithTag("Respawn").GetComponent<Transform>().position.z;
            GameObject.FindWithTag("Player").transform.SetPositionAndRotation(pos, GameObject.FindWithTag("Respawn").GetComponent<Transform>().rotation);

            StartCoroutine(lightOffMuseum());
        }
        else
        {
            //SceneManager.LoadScene(8);
            Debug.Log("8");
        }
        
    }

    

    public void restartScene()
    {
        //SceneManager.LoadScene(8);
        Debug.Log("8");
    }

    IEnumerator lightOffMuseum()
    {
        if (!isRespawned)
        {
            yield return new WaitForSeconds(2.0f);
            DialogueManager.isMonologue = true;
            gameObject.GetComponent<InteractionEvent>().dialogue.line.x = 1;
            gameObject.GetComponent<InteractionEvent>().dialogue.line.y = 6;
            theDM.ShowDialogue(gameObject.GetComponent<InteractionEvent>().GetDialogue());
            yield return new WaitUntil(() => DialogueManager.isRealEnd);
            DialogueManager.isRealEnd = false;

            yield return new WaitUntil(() => DarkMusFirst.firstDial);
            DialogueManager.isMonologue = true;
            gameObject.GetComponent<InteractionEvent>().dialogue.line.x = 7;
            gameObject.GetComponent<InteractionEvent>().dialogue.line.y = 19;
            theDM.ShowDialogue(gameObject.GetComponent<InteractionEvent>().GetDialogue());
            yield return new WaitUntil(() => DialogueManager.isRealEnd);
            DialogueManager.isRealEnd = false;

            yield return new WaitUntil(() => DarkMusSec.secDial);
            isSaved = true;
            DialogueManager.isMonologue = true;
            gameObject.GetComponent<InteractionEvent>().dialogue.line.x = 20;
            gameObject.GetComponent<InteractionEvent>().dialogue.line.y = 22;
            theDM.ShowDialogue(gameObject.GetComponent<InteractionEvent>().GetDialogue());
            yield return new WaitUntil(() => DialogueManager.isRealEnd);
            DialogueManager.isRealEnd = false;

            yield return new WaitUntil(() => DarkMusThird.thirdDial);
            gameObject.GetComponent<PlayableDirector>().enabled = true;

            yield return new WaitForSeconds(21.0f);
            //SceneManager.LoadScene(9);
            Debug.Log("9");
        }
        else
        {
            yield return new WaitUntil(() => DarkMusThird.thirdDial);
            gameObject.GetComponent<PlayableDirector>().enabled = true;
            yield return new WaitForSeconds(21.0f);
            //SceneManager.LoadScene(9);
            Debug.Log("9");

        }

        yield return null;
    }
}
