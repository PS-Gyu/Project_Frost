using Invector.vCharacterController;
using System.Collections;
using UnityEngine;
using UnityEngine.UI;

public class DialogueManager : MonoBehaviour
{
    // Start is called before the first frame update
    [SerializeField] GameObject go_DialogueBar;
    [SerializeField] Text txt_Dialogue;
    //[SerializeField] Text txt_name;
    Dialogue[] dialogues;

    bool isDialogue = false;
    bool isNext = false;  //특정 키 입력 대기

    [SerializeField] float textDelay;

    int lineCount = 0; //대화 카운트
    int contextCount = 0; //대사 카운트


    void Update()
    {
        if (isDialogue)
        {
            if (isNext)
            {
                if (Input.GetKeyDown(KeyCode.E))
                {
                    isNext = false;
                    txt_Dialogue.text = "";
                    if (++contextCount < dialogues[lineCount].contexts.Length)
                    {
                        StartCoroutine(TypeWriter());
                    }
                    else
                    {
                        contextCount = 0;
                        if(++lineCount < dialogues.Length)
                        {
                            StartCoroutine(TypeWriter());
                            
                        }
                        else
                        {
                            GameObject.FindWithTag("Player").SetActive(true);
                            EndDialogue();
                        }
                    }

                }
            }
        }
    }
    public void ShowDialogue(Dialogue[] p_dialogues)
    {
        GameObject.FindWithTag("Player").GetComponent<vThirdPersonController>().enabled = false;
        GameObject.FindWithTag("Player").GetComponent<vThirdPersonInput>().horizontalInput = new GenericInput("", "LeftAnalogHorizontal", "Horizontal");
        GameObject.FindWithTag("Player").GetComponent<vThirdPersonInput>().verticallInput = new GenericInput("", "LeftAnalogVertical", "Vertical");
        GameObject.FindWithTag("Player").GetComponent<vThirdPersonInput>().jumpInput = new GenericInput("", "X", "X");
        GameObject.FindWithTag("Player").GetComponent<vThirdPersonInput>().rollInput = new GenericInput("", "B", "B");
        GameObject.FindWithTag("Player").GetComponent<vThirdPersonInput>().crouchInput = new GenericInput("", "Y", "Y");
        isDialogue = true;
        txt_Dialogue.text = "";
        dialogues = p_dialogues;
        
        StartCoroutine(TypeWriter());
    }

    void EndDialogue()
    {
        GameObject.FindWithTag("Player").GetComponent<vThirdPersonController>().enabled = true;
        GameObject.FindWithTag("Player").GetComponent<vThirdPersonInput>().horizontalInput = new GenericInput("Horizontal", "LeftAnalogHorizontal", "Horizontal");
        GameObject.FindWithTag("Player").GetComponent<vThirdPersonInput>().verticallInput = new GenericInput("Vertical", "LeftAnalogVertical", "Vertical");
        GameObject.FindWithTag("Player").GetComponent<vThirdPersonInput>().jumpInput = new GenericInput("Space", "X", "X");
        GameObject.FindWithTag("Player").GetComponent<vThirdPersonInput>().rollInput = new GenericInput("Q", "B", "B");
        GameObject.FindWithTag("Player").GetComponent<vThirdPersonInput>().crouchInput = new GenericInput("C", "Y", "Y");
        isDialogue = false;
        contextCount = 0;
        lineCount = 0;
        dialogues = null;
        isNext = false;
        SettingUI(false);
    }

    IEnumerator TypeWriter()
    {
        SettingUI(true);
        
        string t_ReplaceText = dialogues[lineCount].contexts[contextCount];
        t_ReplaceText = t_ReplaceText.Replace("'", ",");
        //txt_Name.text = dialogues[lineCount].name;
        /*
         * for (int i = 0; i < t_ReplaceText.Length; i++){
         * txt_Dialogue.text += t_ReplaceText[i];
         * yield return new WaitForSeconds(textDelay);
         */
        txt_Dialogue.text = dialogues[lineCount].name + " : " + t_ReplaceText;
        
        isNext = true;
        yield return null;
    }

    void SettingUI(bool p_flag)
    {
        go_DialogueBar.SetActive(p_flag);
    }
}
