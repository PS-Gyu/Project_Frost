using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BaseFifthDial : MonoBehaviour
{
    public static bool fifthDial = false;
    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    private void OnTriggerEnter(Collider other)
    {
        if (other.tag == "Player")
        {
            if (!fifthDial)
            {
                fifthDial = true;
            }

        }
    }
}
