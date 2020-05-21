using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PicInteract : MonoBehaviour
{
    public bool picInteracted = false;
    public static bool picisInteracted = false;
    // Start is called before the first frame update
    void Start()
    {
        picisInteracted = false;
    }



    // Update is called once per frame
    void Update()
    {
        picisInteracted = picInteracted;
    }
}
